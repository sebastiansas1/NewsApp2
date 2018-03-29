class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :headline
      t.string :subheading
      t.string :topic
      t.string :keyword 
      t.integer :views 
      t.integer :likes 

      t.timestamps
    end
  end
end
