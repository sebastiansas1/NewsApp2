class ArticlesController < ApplicationController
    before_action :find_article, only: [:show, :edit, :update, :destroy]

    def index
        @articles = Article.all.order("created_at DESC")
    end

    def show
    end

    def new 
        @article = Article.new 
    end 

    def create
        @article = Article.new(article_params)

        if @article.save 
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit

    end

    def update
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
            params.require(:article).permit(:headline, :subheading, :topic, :keyword, :views, :likes)
        end

        def find_article
            @article = Article.find(params[:id])
        end 

end
