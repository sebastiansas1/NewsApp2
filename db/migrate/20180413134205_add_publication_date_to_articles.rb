class AddPublicationDateToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :publication_date, :datetime
    add_column :personal_articles, :publication_date, :datetime
  end
end
