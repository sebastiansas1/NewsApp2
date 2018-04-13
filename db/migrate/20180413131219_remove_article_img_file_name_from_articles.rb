class RemoveArticleImgFileNameFromArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :article_img_file_name, :string
    remove_column :articles, :article_img_content_type, :string
    remove_column :articles, :article_img_file_size, :integer
    remove_column :articles, :article_img_updated_at, :datetime
  end
end
