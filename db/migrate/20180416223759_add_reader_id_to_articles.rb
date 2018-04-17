class AddReaderIdToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :reader_id, :integer
  end
end
