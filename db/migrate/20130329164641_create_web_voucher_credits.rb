class CreateWebVoucherCredits < ActiveRecord::Migration
  def change
    create_table :web_voucher_credits do |t|
      t.integer :business_account_id
      t.integer :credits

      t.timestamps
    end
  end
end
