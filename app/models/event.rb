class Event < ActiveRecord::Base
  attr_accessible :active, :business_id, :date_from, :date_to, :details, :email, :featured, :image, :postcode, :prices, :street, :telephone, :title, :town, :website, :url

  belongs_to :business

  mount_uploader :image, ImageUploader

  acts_as_url :title, :sync_url => true

  def to_param
  	url
  end
  
end
