class RemoveCurrentReaderIdFromFriend < ActiveRecord::Migration[5.1]
  def change
    remove_column :friends, :current_reader_id, :integer
  end
end
