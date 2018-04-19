class DropTablePersonalArticle < ActiveRecord::Migration[5.1]
  def change
    drop_table :personal_articles
  end
end
