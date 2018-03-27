class AddNameToReaders < ActiveRecord::Migration[5.1]
  def change
    add_column :readers, :name, :string
  end
end
