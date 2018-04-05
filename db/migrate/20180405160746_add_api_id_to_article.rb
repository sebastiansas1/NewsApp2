class AddApiIdToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :api_id, :string, unique: true
  end
end
