class RemoveAdminIdFromArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :admin_id, :integer
  end
end
