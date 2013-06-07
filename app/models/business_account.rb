class BusinessAccount < ActiveRecord::Base
	has_secure_password

  attr_accessible :email, :password, :password_confirmation

  validates_presence_of :email
  validates :email,
            :format => {
              :with    => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,
              :message => " is not valid" }
  validates_uniqueness_of :email

  has_one :business
  has_many :web_vouchers
  has_one :web_voucher_credit
  has_many :advert_comments
  
  before_save :lower_case_email


  def to_s
    self.business.business_name
  end

  def name_of_business
    self.business.business_name
  end
  
  def lower_case_email
    self.email = self.email.downcase
  end

end
