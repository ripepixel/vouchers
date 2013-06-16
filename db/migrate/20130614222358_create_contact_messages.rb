class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.integer :contact_id
      t.integer :admin_user_id
      t.text :message
      t.boolean :active

      t.timestamps
    end
  end
end
