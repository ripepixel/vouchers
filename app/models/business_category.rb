class BusinessCategory < ActiveRecord::Base
  attr_accessible :name, :icon

  has_many :web_vouchers
  has_many :businesses
  
  before_destroy :check_if_category_has_any_web_vouchers
  
  
  
  private
  def check_if_category_has_any_web_vouchers
    if self.web_vouchers.any?
      return false
    end
  end
  
  
end
