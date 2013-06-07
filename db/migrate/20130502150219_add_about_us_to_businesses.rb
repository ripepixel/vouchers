class AddAboutUsToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :about_us, :text
  end
end
