class DropKeywords < ActiveRecord::Migration[5.1]
  def change
    drop_table :keywords
  end
end
