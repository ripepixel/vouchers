class AddResourceIdToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :resource_id, :string
  end
end
