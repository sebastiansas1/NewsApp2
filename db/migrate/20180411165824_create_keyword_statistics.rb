class CreateKeywordStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :keyword_statistics do |t|
      t.string :name

      t.timestamps
    end
  end
end
