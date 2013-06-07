class Newsletter < ActiveRecord::Base
  attr_accessible :email, :subscribed, :unsubscribe_date
  
  validates_presence_of :email
  validates :email,
            :format => {
              :with    => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,
              :message => " is not valid" }
  validates_uniqueness_of :email, :message => " address is already registered"
  
  
end
