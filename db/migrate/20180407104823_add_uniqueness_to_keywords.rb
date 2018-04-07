class AddUniquenessToKeywords < ActiveRecord::Migration[5.1]
  def change
    change_column :keywords, :name, :string, unique: true
  end
end
