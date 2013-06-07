class AddActiveToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :active, :boolean
  end
end
