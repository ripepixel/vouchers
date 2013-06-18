class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.string :business_name
      t.string :fullname
      t.string :town
      t.text :message
      t.boolean :active
      t.integer :business_id

      t.timestamps
    end
  end
end
