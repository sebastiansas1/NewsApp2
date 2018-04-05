class ChangeRelevanceForPreference < ActiveRecord::Migration[5.1]
  def change
    change_column :preferences, :relevance, :integer, :null => false, :default => 0
  end
end
