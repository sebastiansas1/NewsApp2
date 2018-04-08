class StatisticsController < ApplicationController

    before_action :require_login
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

    def users

    end

    private 

    def require_login
        unless admin_signed_in? 
          redirect_to new_admin_session_path
        end
    end

end
