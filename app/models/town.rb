class Town < ActiveRecord::Base
  attr_accessible :name

  has_many :booklets
  has_many :appointments
  before_destroy :check_if_town_has_booklet
  
  
  
  
  private
  
  def check_if_town_has_booklet
    if self.booklets.any?
      errors[:base] = 'The town has booklets associated with it and can not be deleted'
      return false
    end
  end
  
  
end
