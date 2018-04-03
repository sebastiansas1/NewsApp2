class ArticlesController < ApplicationController
    before_action :find_article, only: [:show, :edit, :update, :destroy, :vote]
    before_action :require_login
    before_action :authenticate_admin!, only: [:new, :edit, :destroy]
    respond_to :js, :json, :html

    def index
        if params[:category].blank?
            @articles = Article.all.order("created_at DESC")
        elsif params[:category] == "Top Trending"
            @articles = Article.all.order(views: :desc, created_at: :desc).limit(8)
            @most_liked_articles = Article.all.order(cached_votes_score: :desc, created_at: :desc).limit(8)
        else
            @category_id = Category.find_by(name: params[:category]).id
            @articles = Article.where(:category_id => @category_id).order("created_at DESC")
        end
    end

    def show
        @related_articles = Article.
                                where(:category_id => @article.category_id).
                                where.not(:id => @article.id).
                                order("created_at DESC").
                                limit(2)
        @related_category = Category.find(@article.category_id).name
        
        if reader_signed_in?
            if current_reader.orders.where(:article_id => @article.id).blank?
                @order = Order.new 
                @article.views += 1
                @article.save
                @order.article_id = @article.id 
                @order.reader_id = current_reader.id 
                @order.save 
            end
        end
    end

    def new 
        @article = current_admin.articles.build 
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end 

    def create
        @article = current_admin.articles.build(article_params)
        @article.category_id = params[:category_id]

        if @article.save 
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def update
        @article.category_id = params[:category_id]
        if @article.update(article_params)
            redirect_to article_path(@article)
        else
            render 'edit'
        end     
    end

    def destroy
        @article.destroy
        redirect_to root_path
    end

    def vote 
        if !current_reader.liked? @article
            @article.liked_by current_reader
        elsif current_reader.liked? @article
            @article.unliked_by current_reader
        end 
    end 

    def history 

        @order = current_reader.orders.all.order("created_at DESC")

        #Retrives all messages and divides into two groups todays messages and other messages
        @grouped_orders = @order.group_by{ |t| t.created_at.to_date == DateTime.now.to_date }

        if @grouped_orders[false].present?
            #Create day wise groups of messages      
            @day_wise_sorted_orders  = @grouped_orders[false].group_by{ |t| t.created_at.strftime("%A #{t.created_at.day.ordinalize} %B, %Y ")}
        end   
        
        @liked_articles = Array.new

        @all_articles = Article.all 

        @all_articles.each do |article|
            if (current_reader.voted_for? article)
                @liked_articles.push article
            end
        end

    end

    def friends

    end
    
    private

        def article_params
            params.require(:article).permit(:headline, :subheading, :category_id, :keyword, :views, :likes, :article_img)
        end

        def find_article
            @article = Article.find(params[:id])
        end 

        def require_login
            unless admin_signed_in? || reader_signed_in? 
              redirect_to new_reader_session_path
            end
        end

end
