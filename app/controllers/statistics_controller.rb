class StatisticsController < ApplicationController
  before_action :require_login
  before_action :find_reader, only: %i[readers preferences keywords]
  before_action :find_preference, only: %i[preferences keywords]
  before_action :find_word, only: [:keywords]
  respond_to :js, :json, :html

  def index

    @readers = Reader.all

    @keywords = Keyword.where(word_type: "Preference").order(name: :asc)

    categories_to_normalize = Category.order(relevance: :desc).limit(10)

    max_relevance_keyword = @keywords.group(:name).sum(:relevance).values.max
    max_relevance_category = categories_to_normalize.sum(:relevance)
  
    normalizer = StatisticsHelper::Normalizer.new
    normalizer.normalize(@keywords, max_relevance_keyword)
    normalizer.normalize(categories_to_normalize, max_relevance_category)

    @categories = Category.order(preferencial_score: :desc).take(10)
    
    @heigth = 15*Keyword.where(word_type: "Preference").count

    @data = @categories.map { |c| [c.name, c.preferencial_score] }.to_h

  end

  def readers
    @preferences = @reader.preferences.order(relevance: :desc)

    @orders = @reader.orders

    @articles = Article.where(reader_id: @reader.id)

    @keywords = Keyword.where(reader_id: @reader.id)

    @heigth = 15*@keywords.count

    max_relevance = @keywords.group(:name).sum(:relevance).values.max

    normalizer = StatisticsHelper::Normalizer.new
    normalizer.normalize(@keywords, max_relevance)

  end

  def preferences
    @keywords = @reader.preferences.find_by(id: @preference.id).keywords

    max_relevance = @keywords.group(:name).sum(:relevance).values.max

    normalizer = StatisticsHelper::Normalizer.new
    normalizer.normalize(@keywords, max_relevance)

    category_id = Category.find_by(name: @preference.category).id

    @categorised_orders = @reader.orders.where(category_id: category_id)

    @heigth = 15*@keywords.count

    @maxvalue = @categorised_orders.group_by_day(:created_at).count.values.max
    @maxvalue += 1

  end


  def keywords
    category_id = Category.find_by(name: @preference.category).id

    orders = @reader.orders.where(category_id: category_id)

    orders.each do |order|
      @keywords = Article.find(order.article_id).keywords

      @keywords.each do |keyword|
        if keyword.name == @word.name
          KeywordStatistic.create(keyword_id: @word.id, name: keyword.name, created_at: order.created_at)
        end
      end
    end

    @maxvalue = KeywordStatistic.where(:keyword_id => @word.id).group_by_day(:created_at).count.values.max
    @maxvalue += 1

  end

  private

  def require_login
    redirect_to new_admin_session_path unless admin_signed_in?
  end

  def find_reader
    @reader = Reader.find(params[:reader_id])
  end

  def find_preference
    @preference = Preference.find(params[:preference_id])
  end

  def find_word
    @word = Keyword.find(params[:keyword_id])
  end
end
