class AddHiddenToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :hidden, :boolean
  end
end
