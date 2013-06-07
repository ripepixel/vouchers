class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.integer :business_account_id
      t.string :business_name
      t.integer :business_category_id
      t.string :street
      t.string :town
      t.string :county
      t.string :postcode
      t.string :telephone
      t.string :website
      t.string :email
      t.string :logo

      t.timestamps
    end
  end
end
