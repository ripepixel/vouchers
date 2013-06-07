class AddUrlToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :url, :string
  end
end
