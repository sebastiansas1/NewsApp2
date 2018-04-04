class MakeHeadlineUniqueInArticles < ActiveRecord::Migration[5.1]
  def change
    change_column :articles, :headline, :string, unique: true
  end
end
