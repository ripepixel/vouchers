class AddImageToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :image, :string
  end
end
