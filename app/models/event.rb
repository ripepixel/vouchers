class Event < ActiveRecord::Base
  attr_accessible :active, :business_id, :date_from, :date_to, :details, :email, :featured, :image, :postcode, :prices, :street, :telephone, :title, :town, :website

  belongs_to :business
end
