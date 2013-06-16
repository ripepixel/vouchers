class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :business_name
      t.string :telephone
      t.string :contact_name
      t.string :street
      t.string :town
      t.string :county
      t.string :postcode
      t.string :email
      t.string :mobile
      t.string :website
      t.integer :created_by
      t.integer :managed_by
      t.integer :business_id
      t.boolean :do_not_contact

      t.timestamps
    end
  end
end
