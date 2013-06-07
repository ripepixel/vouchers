class Business < ActiveRecord::Base
  attr_accessible :business_account_id, :business_category_id, :business_name, :county, :email, :logo, :postcode, :street, :telephone, :town, :website, :image, :about_us

  before_validation :smart_add_url_protocol

  validates_presence_of :business_name

  belongs_to :business_account
  belongs_to :business_category
  has_one :web_voucher_credit, :through => :business_account
  has_many :adverts
  has_many :business_reviews
  has_many :events

  mount_uploader :image, ImageUploader

  acts_as_url :business_name

  def to_s
  	business_name
  end

  def to_param
    business_name
  end


  def smart_add_url_protocol
	  unless self.website[/^http:\/\//] || self.website[/^https:\/\//]
	    self.website = 'http://' + self.website
	  end
  end

  def self.search(what, where)
    if !what.blank?
      where('business_name LIKE ? OR about_us LIKE ?', "%#{what}%", "%#{what}%")
    elsif !where.blank?
      where('town LIKE ? OR county LIKE ?', "%#{where}%", "%#{where}%")
    elsif what && where
      where('business_name LIKE ? OR about_us LIKE ? AND town LIKE ? OR county LIKE ?', "%#{what}%", "%#{what}%", "%#{where}%", "%#{where}%")
    end
  end


end
