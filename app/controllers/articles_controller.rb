class ArticlesController < ApplicationController

  before_action :find_article, only: %i[show vote]
  before_action :require_login
  skip_before_action :verify_authenticity_token, only: [:show]
  respond_to :js, :json, :html

  def index
    @title = 'Homepage'

    if params[:category].blank?
      @articles = Article.all.order('created_at DESC')
    elsif params[:category] == 'Top Trending'
      @title = 'Homepage - Top Trending'
      @articles = Article.all.order(views: :desc, created_at: :desc).limit(8)
      @most_liked_articles = Article.all.order(cached_votes_score: :desc, created_at: :desc).limit(8)
    else
      @title = "Homepage - #{params[:category]}"
      @category_id = Category.find_by(name: params[:category]).id
      @articles = Article.where(category_id: @category_id).order('created_at DESC')
    end
  end

  def show
    @title = @article.headline

    @related_articles = Article
                        .where(category_id: @article.category_id)
                        .where.not(id: @article.id)
                        .order('created_at DESC')
                        .limit(2)
    @related_category = Category.find(@article.category_id).name

    if reader_signed_in?
      if current_reader.orders.where(article_id: @article.id).blank?

        @article.increment!(:views)

        current_reader.orders.create(article_id: @article.id, reader_id: current_reader.id, category_id: @article.category_id, created_at: Time.now, updated_at: Time.now)

        Category.find(@article.category_id).increment!(:relevance)

        @keywords = @article.keywords.all

        current_reader.preferences.create(category: @related_category, created_at: Time.now, updated_at: Time.now)
        current_reader.preferences.find_by(category: @related_category).increment!(:relevance)

        @keywords.each do |keyword|
          next if keyword == @related_category

          current_reader.preferences.find_by(category: @related_category).keywords.create(name: keyword.name, tag: keyword.tag, created_at: Time.now, updated_at: Time.now)
          word = current_reader.preferences.find_by(category: @related_category).keywords.find_by(name: keyword.name)

          unless word.nil?
            word.relevance += 1
            word.save
          end
        end
      end
    end
  end

  def vote
    if !current_reader.liked? @article

      @article.liked_by current_reader
      @keywords = @article.keywords.all
      @related_category = Category.find(@article.category_id).name
      current_reader.preferences.find_by(category: @related_category).increment!(:relevance)

      @keywords.each do |keyword|
        next if keyword == @related_category

        word = current_reader.preferences.find_by(category: @related_category).keywords.find_by(name: keyword.name)

        unless word.nil?
          word.relevance += 1
          word.save
        end
      end

    elsif current_reader.liked? @article

      @article.unliked_by current_reader

    end
  end

  def history
    @title = 'History'

    @order = current_reader.orders.all.order('created_at DESC')

    # Retrives all orders and divides into two groups today's orders and other day's orders
    @grouped_orders = @order.group_by { |t| t.created_at.to_date == DateTime.now.to_date }

    if @grouped_orders[false].present?
      # Create day wise groups of orders
      @day_wise_sorted_orders = @grouped_orders[false].group_by { |t| t.created_at.strftime("%A #{t.created_at.day.ordinalize} %B, %Y ") }
    end

    @liked_articles = []

    @all_articles = Article.all.order(created_at: :desc)

    @all_articles.each do |article|
      @liked_articles.push article if current_reader.voted_for? article
    end
  end

  def friends
    @title = 'Homepage - Friends'

    @friends = current_reader.friends.all.order(strength: :desc)

    @array = []

    @friends.each do |friend|
      @reader = Reader.find(friend.friend_id)
      @reader_orders = @reader.orders.all.order(created_at: :desc)
      @grouped_articles_by_reader = @reader_orders.group_by(&:reader_id)
      @array.push @grouped_articles_by_reader
    end
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def require_login
    redirect_to new_reader_session_path unless reader_signed_in?
  end
end
