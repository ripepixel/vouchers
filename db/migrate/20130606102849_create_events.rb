class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :business_id
      t.string :title
      t.text :details
      t.string :image
      t.date :date_from
      t.date :date_to
      t.text :prices
      t.string :street
      t.string :town
      t.string :postcode
      t.string :telephone
      t.string :website
      t.string :email
      t.boolean :active
      t.boolean :featured

      t.timestamps
    end
  end
end
