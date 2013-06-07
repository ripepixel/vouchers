class AddAcceptedToAdvertComments < ActiveRecord::Migration
  def change
    add_column :advert_comments, :accepted, :boolean
  end
end
