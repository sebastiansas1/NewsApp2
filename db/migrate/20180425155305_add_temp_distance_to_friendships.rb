class AddTempDistanceToFriendships < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :temp_distance, :float
  end
end
