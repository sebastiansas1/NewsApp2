class AddPreferencialScoreToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :preferencial_score, :float
  end
end
