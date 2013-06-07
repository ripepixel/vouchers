class Commission < ActiveRecord::Base
  attr_accessible :admin_user_id, :advert_size_id, :rate, :active

  belongs_to :admin_user
  belongs_to :advert_size
  
  validates_uniqueness_of :advert_size_id, :scope => [:admin_user_id, :active]
end
