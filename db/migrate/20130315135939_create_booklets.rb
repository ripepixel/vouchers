class CreateBooklets < ActiveRecord::Migration
  def change
    create_table :booklets do |t|
      t.string :name
      t.integer :town_id
      t.string :month
      t.string :year

      t.timestamps
    end
  end
end
