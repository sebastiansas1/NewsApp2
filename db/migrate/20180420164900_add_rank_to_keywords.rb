class AddRankToKeywords < ActiveRecord::Migration[5.1]
  def change
    add_column :keywords, :preferencial_score, :float
  end
end
