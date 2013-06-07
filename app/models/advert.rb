class Advert < ActiveRecord::Base
  attr_accessible :advert_cost, :advert_size_id, :booklet_id, :business_id, :paid, :image, :valid_from, :valid_to, :featured, :resource_id, :admin_user_id

  belongs_to :booklet
  belongs_to :business
  belongs_to :advert_size
  belongs_to :admin_user
  has_many :advert_comments

  mount_uploader :image, ImageUploader
  
  before_create :set_valid_from, :set_expiry_date, :set_cost_if_not_defined
  
  def total_units
    advert_size.page_unit
  end

  def set_valid_from
    self.valid_from = self.booklet.start_date
  end
  
  def set_expiry_date
    self.valid_to = self.valid_from.at_end_of_month
  end
  
  def set_cost_if_not_defined
    if self.advert_cost.nil?
      ad_cost = AdvertSize.find(self.advert_size_id)
      self.advert_cost = ad_cost.cost
    else
      self.advert_cost
    end
  end

end
