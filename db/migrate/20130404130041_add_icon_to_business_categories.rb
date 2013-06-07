class AddIconToBusinessCategories < ActiveRecord::Migration
  def change
    add_column :business_categories, :icon, :string
  end
end
