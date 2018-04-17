class AddCategoryIdToKeyword < ActiveRecord::Migration[5.1]
  def change
    add_column :keywords, :category_id, :integer
  end
end
