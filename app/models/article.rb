class Article < ActiveRecord::Base
  attr_accessible :article_category_id, :author_name, :body, :image, :published, :tags, :title, :url
  
  belongs_to :article_category
  has_many :article_comments

  acts_as_url :title, :sync_url => true
  
  mount_uploader :image, ImageUploader

  

  def to_param
    url
  end
  
  def previous_article
  	self.class.first(:conditions => ["created_at < ? AND published = ?", created_at, true], :order => "created_at desc")
	end

	def next_article
 		self.class.first(:conditions => ["created_at > ? AND published = ?", created_at, true], :order => "created_at asc")
	end
  
end
