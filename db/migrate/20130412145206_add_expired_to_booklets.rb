class AddExpiredToBooklets < ActiveRecord::Migration
  def change
    add_column :booklets, :expired, :boolean
    add_column :booklets, :cut_off_date, :date
    add_column :booklets, :start_date, :date
  end
end
