class AddPreferenceIdToReader < ActiveRecord::Migration[5.1]
  def change
    add_column :readers, :preference_id, :integer
  end
end
