class PersonalArticlesController < ApplicationController
  include ApiHelper

  before_action :find_article, only: %i[show vote]
  before_action :find_reader, only: %i[]
  before_action :require_login

  def index
    @personal_articles = current_reader.personal_articles.order(publication_date: :desc)
  end

  def show; end

  private

  def find_article
    @personal_article = PersonalArticle.find(params[:article_id])
  end

  def find_reader
    @reader = Reader.find(params[:reader_id])
  end

  def require_login
    redirect_to new_reader_session_path unless reader_signed_in?
  end
end
