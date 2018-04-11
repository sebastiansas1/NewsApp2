class AddKeywordIdToKeywordStatistic < ActiveRecord::Migration[5.1]
  def change
    add_column :keyword_statistics, :keyword_id, :integer
  end
end
