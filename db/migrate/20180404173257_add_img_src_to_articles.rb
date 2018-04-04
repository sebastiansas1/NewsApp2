class AddImgSrcToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :img_src, :string
  end
end
