module ArticlesHelper

	def has_articles(cat)
  		categ = ArticleCategory.find(cat)
  		if categ.articles.count > 0
  			return true
  		else
  			return false
  		end
  	end
	
end
