class AddDefaultRelevanceToKeywords < ActiveRecord::Migration[5.1]
  def change
    change_column :keywords, :relevance, :integer, :null => false, :default => 0
  end
end
