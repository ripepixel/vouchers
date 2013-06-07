class WebVoucherCredit < ActiveRecord::Base
  attr_accessible :business_account_id, :credits
  
  belongs_to :business_account
  has_one :business, :through => :business_account
end
