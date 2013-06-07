class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :email
      t.boolean :subscribed
      t.date :unsubscribe_date

      t.timestamps
    end
  end
end
