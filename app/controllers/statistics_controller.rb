class StatisticsController < ApplicationController
  before_action :require_login
  before_action :find_reader, only: %i[readers preferences keywords]
  before_action :find_preference, only: %i[preferences keywords]
  before_action :find_word, only: [:keywords]
  respond_to :js, :json, :html

  def index
    # ALL READERS
    @readers = Reader.all

    # ALL CATEGORIES - Maybe Table
    @categories = Category.order(relevance: :desc).take(10)
    
    @data = @categories.map { |c| [c.name, c.relevance] }.to_h

    @heigth = 20*Keyword.where(word_type: "Preference").count

    @keywords = Keyword.where(word_type: "Preferences")

    normalizer = StatisticsHelper::Normalizer.new

    normalizer.normalize(@keywords)

  end

  def readers
    @preferences = @reader.preferences.order(relevance: :desc)

    @orders = @reader.orders

    @articles = Article.where(reader_id: @reader.id)

    @keywords = Keyword.where(reader_id: @reader.id)

  end

  def preferences
    @keywords = @reader.preferences.find_by(id: @preference.id).keywords

    normalizer = StatisticsHelper::Normalizer.new

    normalizer.normalize(@keywords)

    category_id = Category.find_by(name: @preference.category).id

    @categorised_orders = @reader.orders.where(category_id: category_id)

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
