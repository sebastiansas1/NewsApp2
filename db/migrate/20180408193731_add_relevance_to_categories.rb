class AddRelevanceToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :relevance, :integer, :null => false, :default => 0
  end
end
