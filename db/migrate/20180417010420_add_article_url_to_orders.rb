class AddArticleUrlToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :article_url, :string
  end
end
