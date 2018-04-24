class ArticlesController < ApplicationController

  before_action :find_article, only: %i[show vote]
  before_action :find_reader, only: %i[index_personal]
  before_action :require_login
  respond_to :js, :json, :html

  def index
    @title = 'Homepage'
    @orders = current_reader.orders.all.order(created_at: :desc)

    if params[:category].blank? && params[:topic].blank?
      @articles = Article.where(reader_id: nil).order(publication_date: :desc)
    elsif params[:category] == 'Top Trending'
      @title = 'Homepage - Trending'
      @trending = Keyword.where(word_type: "Preference").group(:name).sum(:relevance).sort_by { |name, relevance, id| relevance}.reverse[0..50]
      @analyzer = StatisticsHelper::Analyzer.new
    elsif !params[:topic].blank?  
      @articles = []     
      @topics = Keyword.where(word_type: "Article").where(name: params[:topic])    
      @topics.each do |topic|
        @articles.push Article.find(topic.word_id)
      end
      @articles = @articles.sort_by{|e| e[:publication_date]}.reverse
    elsif params[:category] != 'Top Trending' && params[:topic].blank?
      @title = "Homepage - #{params[:category]}"
      @category_id = Category.find_by(name: params[:category]).id
      @articles = Article.select('DISTINCT ON (publication_date, api_id,headline) *').where(category_id: @category_id).order(publication_date: :desc)
    end
  end

  def index_personal

    @title = 'For You'
    @orders = current_reader.orders.all.order(created_at: :desc)
    @articles = Article.where(reader_id: @reader.id)

  end

  def show
    @title = @article.headline

    @related_articles = Article
                        .where(category_id: @article.category_id)
                        .where.not(api_id: @article.api_id)
                        .order(publication_date: :desc)
                        .limit(9)
    @better_related_articles = @related_articles.select('DISTINCT ON (publication_date, api_id,headline) *')
    @related_category = Category.find(@article.category_id).name

    if reader_signed_in?
      if current_reader.orders.where(article_id: @article.id).blank?

        @article.increment!(:views)

        current_reader.orders.create(article_id: @article.id, article_url: @article.api_id, reader_id: current_reader.id, category_id: @article.category_id, created_at: Time.now, updated_at: Time.now)

        Category.find(@article.category_id).increment!(:relevance)

        @keywords = @article.keywords.all

        current_reader.preferences.create(category: @related_category, created_at: Time.now, updated_at: Time.now)
        current_reader.preferences.find_by(category: @related_category).increment!(:relevance)

        @keywords.each do |keyword|
          next if keyword == @related_category

          current_reader.preferences.find_by(category: @related_category).keywords.create(name: keyword.name, tag: keyword.tag, reader_id: current_reader.id, category_id: @article.category_id, created_at: Time.now, updated_at: Time.now)
          word = current_reader.preferences.find_by(category: @related_category).keywords.find_by(name: keyword.name)
          KeywordStatistic.create(keyword_id: word.id, name: word.name, created_at: Time.now)

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

    @order = current_reader.orders.all.order(created_at: :desc)

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

  def find_reader
    @reader = Reader.find(params[:reader_id])
  end

  def require_login
    redirect_to new_reader_session_path unless reader_signed_in?
  end
end
