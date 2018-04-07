class RemoveUnusedColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :readers, :preference_id, :integer
    remove_column :articles, :keyword_id, :integer
    remove_column :preferences, :keyword_id, :integer
  end
end
