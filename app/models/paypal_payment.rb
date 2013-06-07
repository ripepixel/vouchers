class PaypalPayment < ActiveRecord::Base
  attr_accessible :params, :status, :txn_id, :web_voucher_id, :advert_id
  
  belongs_to :web_voucher
  belongs_to :advert
  serialize :params
  

end
