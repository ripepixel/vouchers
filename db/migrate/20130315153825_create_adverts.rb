class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.integer :booklet_id
      t.integer :business_id
      t.integer :advert_size_id
      t.decimal :advert_cost
      t.boolean :paid
      t.date :valid_from
      t.date :valid_to
      t.boolean :featured

      t.timestamps
    end
  end
end
