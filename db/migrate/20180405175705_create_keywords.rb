class CreateKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :keywords do |t|
      t.string :name, unique: true
      t.integer :relevance

      t.timestamps
    end
  end
end
