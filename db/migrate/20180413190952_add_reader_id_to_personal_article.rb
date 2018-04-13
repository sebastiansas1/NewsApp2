class AddReaderIdToPersonalArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :personal_articles, :reader_id, :integer
  end
end
