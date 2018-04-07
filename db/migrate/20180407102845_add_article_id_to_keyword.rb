class AddArticleIdToKeyword < ActiveRecord::Migration[5.1]
  def change
    add_column :keywords, :article_id, :integer
  end
end
