class Contact < ActiveRecord::Base
  attr_accessible :business_id, :business_name, :contact_name, :county, :created_by, :do_not_contact, :email, :managed_by, :mobile, :postcode, :street, :telephone, :town, :website, :business_category_id, :admin_user_id
  
  belongs_to :business_category
  belongs_to :admin_user
  has_one :business
  has_many :appointments
  has_many :contact_messages
  
  validates :business_name, :telephone, :presence => true
end
