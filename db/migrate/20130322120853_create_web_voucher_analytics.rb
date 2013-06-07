class CreateWebVoucherAnalytics < ActiveRecord::Migration
  def change
    create_table :web_voucher_analytics do |t|
      t.integer :web_voucher_id
      t.boolean :viewed
      t.boolean :printed
      t.boolean :thumbs_up
      t.boolean :thumbs_down
      t.string :remote_ip

      t.timestamps
    end
  end
end
