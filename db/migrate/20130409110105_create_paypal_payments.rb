class CreatePaypalPayments < ActiveRecord::Migration
  def change
    create_table :paypal_payments do |t|
      t.integer :web_voucher_id
      t.integer :advert_id
      t.text :params
      t.string :status
      t.string :txn_id

      t.timestamps
    end
  end
end
