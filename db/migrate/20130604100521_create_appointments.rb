class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :admin_user_id
      t.string :business_name
      t.integer :town_id
      t.string :telephone
      t.string :contact_name
      t.text :comments
      t.datetime :appointment_time
      t.integer :advert_size_id

      t.timestamps
    end
  end
end
