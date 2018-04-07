class CreateKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :keywords do |t|
      t.string :name
      t.integer :relevance
      t.references :word, polymorphic: true, index: true

      t.timestamps
    end
  end
end
