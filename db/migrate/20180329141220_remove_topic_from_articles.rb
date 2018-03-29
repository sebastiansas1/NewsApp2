class RemoveTopicFromArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :topic, :string
  end
end
