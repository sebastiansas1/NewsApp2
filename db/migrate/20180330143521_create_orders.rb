class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :article_id
      t.integer :reader_id

      t.timestamps
    end
  end
end
