class AddBusinessCategoryIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :business_category_id, :integer
  end
end
