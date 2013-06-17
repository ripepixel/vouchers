class WebVoucher < ActiveRecord::Base
  attr_accessible :advert_id, :business_account_id, :details, :expiry_date, :featured, :start_date, :terms, :title, :business_category_id, :status, :town_id, :url, :resource_id, :town, :weblink

  belongs_to :business_account
  has_one :business, :through => :business_account
  belongs_to :business_category
  has_many :web_voucher_analytics

  before_validation :check_weblink

  before_create :set_expiry_date

  acts_as_url :title, :sync_url => true

  validates :title, :details, :terms, :presence => :true

  scope :exclude_featured, lambda {
  	featured = WebVoucher.where("featured = ?", true)
  	return [] unless featured
  	if featured.any?
  	  feat = featured.map(&:id)
  	else
  	  feat = 0
  	end
  	where("id NOT IN (?)", feat)
  }
  
  scope :not_expired, lambda { where("start_date <= ? AND expiry_date >= ?", Date.today.beginning_of_day, Date.today.end_of_day) }
  
  scope :has_paid, where(:status => 'Paid')

  def self.search(search)
  	if search
  		joins(:business).where('title LIKE ? OR details LIKE ? OR web_vouchers.town LIKE ? or business_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  	else
  		scoped
  	end
  end

  def to_param
    url
  end


  def set_expiry_date
    self.expiry_date = self.start_date + 1.month
  end
  
  def check_weblink
    if !self.weblink.blank?
	    unless self.weblink[/^http:\/\//] || self.weblink[/^https:\/\//]
  	    self.weblink = 'http://' + self.weblink
  	  end
  	end
  end

  


end
