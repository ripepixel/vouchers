class ContactMessage < ActiveRecord::Base
  attr_accessible :active, :admin_user_id, :contact_id, :message
end
