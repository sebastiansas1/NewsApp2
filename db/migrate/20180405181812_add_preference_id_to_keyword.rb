class AddPreferenceIdToKeyword < ActiveRecord::Migration[5.1]
  def change
    add_column :keywords, :preference_id, :integer
  end
end
