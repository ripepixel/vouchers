class CreateBusinessReviews < ActiveRecord::Migration
  def change
    create_table :business_reviews do |t|
      t.integer :business_id
      t.string :email
      t.string :name
      t.integer :rating
      t.text :comments
      t.boolean :published
      t.boolean :active

      t.timestamps
    end
  end
end
