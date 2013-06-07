class CreateAdvertPayments < ActiveRecord::Migration
  def change
    create_table :advert_payments do |t|
      t.integer :advert_id
      t.text :params
      t.string :status
      t.string :txn_id

      t.timestamps
    end
  end
end
