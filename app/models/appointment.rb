class Appointment < ActiveRecord::Base
  attr_accessible :admin_user_id, :advert_size_id, :comments, :contact_name, :business_name, :telephone, :town_id, :appointment_time

  belongs_to :admin_user
  belongs_to :town
  belongs_to :advert_size



  
end
