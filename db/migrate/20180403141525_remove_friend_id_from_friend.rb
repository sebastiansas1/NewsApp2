class RemoveFriendIdFromFriend < ActiveRecord::Migration[5.1]
  def change
    remove_column :friends, :friend_id, :integer
  end
end
