class RemoveUnusedColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :preferences, :keyword_id, :integer
  end
end
