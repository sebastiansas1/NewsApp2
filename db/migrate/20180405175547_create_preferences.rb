class CreatePreferences < ActiveRecord::Migration[5.1]
  def change
    create_table :preferences do |t|
      t.string :category, unique: true
      t.integer :relevance
      t.integer :keyword_id

      t.timestamps
    end
  end
end
