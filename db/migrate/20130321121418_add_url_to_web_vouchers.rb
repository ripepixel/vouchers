class AddUrlToWebVouchers < ActiveRecord::Migration
  def change
    add_column :web_vouchers, :url, :string
  end
end
