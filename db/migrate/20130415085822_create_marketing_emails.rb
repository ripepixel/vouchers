class CreateMarketingEmails < ActiveRecord::Migration
  def change
    create_table :marketing_emails do |t|
      t.string :email
      t.boolean :subscribed

      t.timestamps
    end
  end
end
