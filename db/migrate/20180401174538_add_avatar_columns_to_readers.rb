class AddAvatarColumnsToReaders < ActiveRecord::Migration[5.1]
  def up
    add_attachment :readers, :avatar
  end

  def down
    remove_attachment :readers, :avatar
  end
end
