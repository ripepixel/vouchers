module ApplicationHelper

	def flash_class(level)
		case level
			when :notice then "info"
			when :error then "error"
			when :alert then "warning"
		end
	end

	def page_title
  	(@page_title + " - " if @page_title).to_s + 'Red Hot Voucher Book'
  end

  def meta_key
  	(@meta_key if @meta_key).to_s
  end

  def meta_desc
  	(@meta_desc if @meta_desc).to_s
  end
	
	def latest_blog_articles
    Article.where('published = ?', true).order('created_at DESC').limit(3)
  end
	
end
