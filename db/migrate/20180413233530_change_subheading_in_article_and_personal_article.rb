class ChangeSubheadingInArticleAndPersonalArticle < ActiveRecord::Migration[5.1]
  def change
    change_column :articles, :subheading, :text
    change_column :personal_articles, :subheading, :text
  end
end
