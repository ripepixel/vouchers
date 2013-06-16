class AddAdminUserIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :admin_user_id, :integer
  end
end
