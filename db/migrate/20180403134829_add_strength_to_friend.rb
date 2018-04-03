class AddStrengthToFriend < ActiveRecord::Migration[5.1]
  def change
    add_column :friends, :strength, :integer
  end
end
