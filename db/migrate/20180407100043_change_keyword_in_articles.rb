class ChangeKeywordInArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :keyword, :string
    add_column :articles, :keyword_id, :integer
  end
end
