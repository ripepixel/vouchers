class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.integer :admin_user_id
      t.integer :advert_size_id
      t.decimal :rate

      t.timestamps
    end
  end
end
