class AddTownIdToWebVouchers < ActiveRecord::Migration
  def change
    add_column :web_vouchers, :town_id, :integer
  end
end
