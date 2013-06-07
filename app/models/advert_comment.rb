class AdvertComment < ActiveRecord::Base
  attr_accessible :admin_user_id, :advert_id, :business_account_id, :comment, :image, :accepted
  
  belongs_to :advert
  belongs_to :business_account
  belongs_to :admin_user
  
  mount_uploader :image, ImageUploader
  
end
