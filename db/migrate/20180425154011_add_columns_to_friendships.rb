class AddColumnsToFriendships < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :similarity, :float, :null => false, :default => 0.0
    add_column :friendships, :distance, :float, :null => false, :default => 100.0
    remove_column :friendships, :strength, :integer
  end
end
