class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :auth_level
  # attr_accessible :title, :body
  
  has_many :advert_comments
  has_many :appointments
  has_many :adverts
  has_many :commissions
  has_many :contacts
  has_many :contact_messages
  
  def to_s
    fullname
  end
end
