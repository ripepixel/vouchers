class AddAdminUserIdToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :admin_user_id, :integer
  end
end
