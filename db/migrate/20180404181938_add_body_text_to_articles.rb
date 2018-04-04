class AddBodyTextToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :body_text, :text
  end
end
