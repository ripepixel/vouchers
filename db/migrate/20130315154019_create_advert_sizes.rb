class CreateAdvertSizes < ActiveRecord::Migration
  def change
    create_table :advert_sizes do |t|
      t.string :name
      t.decimal :cost
      t.integer :page_unit
      t.boolean :active

      t.timestamps
    end
  end
end
