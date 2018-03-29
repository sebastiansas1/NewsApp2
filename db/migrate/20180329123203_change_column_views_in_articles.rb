class ChangeColumnViewsInArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :views, :integer
    remove_column :articles, :likes, :integer
  end
end
