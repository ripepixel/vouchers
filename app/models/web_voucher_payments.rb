class WebVoucherPayments < ActiveRecord::Base
  attr_accessible :params, :status, :txn_id, :web_voucher_id
  
  belongs_to :web_voucher
  serialize :params
  after_create :mark_web_advert_as_purchased
  
  
  private
  def mark_web_advert_as_purchased
   if status == "Completed"
     web_voucher.update_attributes(status: 'Paid')
   end
  end
  
end
