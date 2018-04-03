class AddCurrentReaderToFriend < ActiveRecord::Migration[5.1]
  def change
    add_column :friends, :current_reader_id, :integer
  end
end
