class CreateWebVouchers < ActiveRecord::Migration
  def change
    create_table :web_vouchers do |t|
      t.integer :business_account_id
      t.string :title
      t.text :details
      t.text :terms
      t.date :start_date
      t.date :expiry_date
      t.integer :advert_id
      t.boolean :featured

      t.timestamps
    end
  end
end
