class AddViewsAndLikesToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :views, :integer, :null => false, :default => 0
    add_column :articles, :likes, :integer, :null => false, :default => 0
  end
end
