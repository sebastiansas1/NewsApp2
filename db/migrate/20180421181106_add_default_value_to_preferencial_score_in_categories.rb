class AddDefaultValueToPreferencialScoreInCategories < ActiveRecord::Migration[5.1]
  def change
    change_column :categories, :preferencial_score, :float, :null => false, :default => 0.0
  end
end
