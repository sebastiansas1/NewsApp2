class AddPreferencialScoreToPreferences < ActiveRecord::Migration[5.1]
  def change
    add_column :preferences, :preferencial_score, :float, :null => false, :default => 0.0
  end
end
