class AddTagToKeyword < ActiveRecord::Migration[5.1]
  def change
    add_column :keywords, :tag, :string
  end
end
