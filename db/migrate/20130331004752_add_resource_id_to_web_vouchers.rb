class AddResourceIdToWebVouchers < ActiveRecord::Migration
  def change
    add_column :web_vouchers, :resource_id, :string
  end
end
