class CreateWebVoucherPayments < ActiveRecord::Migration
  def change
    create_table :web_voucher_payments do |t|
      t.integer :web_voucher_id
      t.text :params
      t.string :status
      t.string :txn_id

      t.timestamps
    end
  end
end
