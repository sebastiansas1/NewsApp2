class AddAutoIncrementToArticles < ActiveRecord::Migration[5.1]
  def change
    change_column :articles, :id, :integer, auto_increment: true 
  end
end
