class BusinessReview < ActiveRecord::Base
  attr_accessible :active, :business_id, :comments, :email, :name, :published, :rating

  belongs_to :business

end
