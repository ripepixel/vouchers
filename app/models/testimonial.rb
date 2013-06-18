class Testimonial < ActiveRecord::Base
  attr_accessible :active, :business_id, :business_name, :fullname, :message, :town
end
