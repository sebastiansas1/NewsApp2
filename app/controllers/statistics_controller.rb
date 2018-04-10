class StatisticsController < ApplicationController

    before_action :require_login
    before_action :find_reader, only: [:readers, :preferences]
    before_action :find_preference, only: [:preferences]
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
 
        @day_wise_sorted_orders  = @categorised_orders.group_by{ |t| t.created_at.strftime("%A %B %Y ")}

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

end
