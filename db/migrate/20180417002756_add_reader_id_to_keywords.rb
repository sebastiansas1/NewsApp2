class AddReaderIdToKeywords < ActiveRecord::Migration[5.1]
  def change
    add_column :keywords, :reader_id, :integer
  end
end
