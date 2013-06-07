class AddWeblinkToWebVouchers < ActiveRecord::Migration
  def change
    add_column :web_vouchers, :weblink, :string
  end
end
