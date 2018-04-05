class AddReaderIdToPreference < ActiveRecord::Migration[5.1]
  def change
    add_column :preferences, :reader_id, :integer
  end
end
