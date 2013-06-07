class CreateAdvertComments < ActiveRecord::Migration
  def change
    create_table :advert_comments do |t|
      t.integer :advert_id
      t.integer :business_account_id
      t.integer :admin_user_id
      t.string :image
      t.text :comment

      t.timestamps
    end
  end
end
