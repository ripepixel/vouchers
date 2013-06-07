class AdvertSize < ActiveRecord::Base
  attr_accessible :active, :cost, :name, :page_unit

  has_many :adverts
  has_many :appointments
  has_many :commissions
  
  
  def name_with_price
  	"#{name} - #{helpers.number_to_currency(cost)}"
  end

  def helpers
      ActionController::Base.helpers
    end

end
