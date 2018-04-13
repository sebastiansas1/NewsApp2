class CreatePersonalArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :personal_articles do |t|
      t.string :api_id
      t.string :headline
      t.string :subheading
      t.string :img_src
      t.text :body_text
      t.integer :category_id
      t.integer :views, null: false, default: 0
      t.integer :likes, null: false, default: 0
      t.integer :rank, null: false, default: 0

      t.integer :cached_votes_total, default: 0
      t.integer :cached_votes_score, default: 0
      t.integer :cached_votes_up, default: 0
      t.integer :cached_votes_down, default: 0
      t.integer :cached_weighted_score, default: 0
      t.integer :cached_weighted_total, default: 0
      t.float :cached_weighted_average, default: 0

      t.timestamps
    end
  end
end
