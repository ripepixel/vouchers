class AddAuthLevelToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :auth_level, :string
  end
end
