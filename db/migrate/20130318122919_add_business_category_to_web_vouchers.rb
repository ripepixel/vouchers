class AddBusinessCategoryToWebVouchers < ActiveRecord::Migration
  def change
    add_column :web_vouchers, :business_category_id, :integer
    add_column :web_vouchers, :status, :string
  end
end
