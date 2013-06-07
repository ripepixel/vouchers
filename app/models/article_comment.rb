class ArticleComment < ActiveRecord::Base
  attr_accessible :active, :article_id, :comment, :email, :name
  
  belongs_to :article
  
  scope :have_been_reviewed, where('active = ?', true)
  
end
