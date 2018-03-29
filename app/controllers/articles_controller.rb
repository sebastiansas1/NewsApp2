class ArticlesController < ApplicationController
    before_action :find_article, only: [:show, :edit, :update, :destroy]
    before_action :require_login

    def index
        if params[:category].blank?
            @articles = Article.all.order("created_at DESC")
        else
            @category_id = Category.find_by(name: params[:category]).id
            @articles = Article.where(:category_id => @category_id).order("created_at DESC")
        end
    end

    def show
        if reader_signed_in?
            @article.views += 1
            @article.save
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
