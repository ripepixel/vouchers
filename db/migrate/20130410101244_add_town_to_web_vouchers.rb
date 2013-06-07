class AddTownToWebVouchers < ActiveRecord::Migration
  def change
    add_column :web_vouchers, :town, :string
  end
end
