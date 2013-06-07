class CreateBusinessAccounts < ActiveRecord::Migration
  def change
    create_table :business_accounts do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
