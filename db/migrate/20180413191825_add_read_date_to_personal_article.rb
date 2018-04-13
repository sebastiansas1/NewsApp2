class AddReadDateToPersonalArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :personal_articles, :read_date, :datetime
  end
end
