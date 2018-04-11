class StatisticsController < ApplicationController

    before_action :require_login
    before_action :find_reader, only: [:readers, :preferences, :keywords]
    before_action :find_preference, only: [:preferences, :keywords]
    before_action :find_word, only: [:keywords]
    respond_to :js, :json, :html

    def index 
        #ALL READERS
        @readers = Reader.all

        #ALL CATEGORIES - Maybe Table
        categories = Category.order(relevance: :desc).take(10)

        @data = categories.map{ |c| [c.name, c.relevance] }.to_h
 
        #ALL KEYWORDS - Maybe Table
        @keywords = Keyword.order(relevance: :desc).take(20)
    end

    def readers
        @preferences = @reader.preferences.order(relevance: :desc)
    end

    def preferences

        @keywords = @reader.preferences.find_by(:id => @preference.id).keywords.order(relevance: :desc)

        category_id = Category.find_by(:name => @preference.category).id 

        @categorised_orders = @reader.orders.where(:category_id => category_id).order(created_at: :asc)

    end

    def keywords

        category_id = Category.find_by(:name => @preference.category).id 

        orders = @reader.orders.where(:category_id => category_id) 

        orders.each do |order|
            
            @keywords = Article.find(order.article_id).keywords

            @keywords.each do |keyword|
                if keyword.name == @word.name
                    KeywordStatistic.create(keyword_id: @word.id, name: keyword.name, created_at: order.created_at)
                end
            end
        end
    end

    private 

    def require_login
        unless admin_signed_in? 
          redirect_to new_admin_session_path
        end
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
