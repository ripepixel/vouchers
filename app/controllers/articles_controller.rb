class ArticlesController < ApplicationController
  
  before_filter :authenticate_admin_user!, except: [:index, :show, :category]
  before_filter :get_article_cats
  
  def index
    @articles = Article.where("published = ?", true).order("created_at DESC").paginate(:page => params[:page], :per_page => ARTICLES_PER_PAGE)
    @page_title = "#{@articles.first.title} - Blog"
    
  end
  
  def show
    @article = Article.find_by_url(params[:id])
    
    @page_title = @article.title
    @meta_desc = ActionController::Base.helpers.truncate(ActionController::Base.helpers.strip_tags(@article.body), :length => 250)
    
    @comments = ArticleComment.where('article_id = ? AND active = ?', @article.id, true)
    if @article.nil?
      redirect_to articles_path, alert: "Sorry, that page does not exist"
    end
  end

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new
    if @article.save
      redirect_to manager_articles_path, notice: "The article has been saved"
    else
      flash.now[:alert] = "There was a problem saving the article"
      render new
    end
  end

  def category
    categ = ArticleCategory.find_by_name(params[:name])
    if categ.nil?
      redirect_to articles_path
    else
      @articles = Article.where("article_category_id = ? AND published = ?", categ.id, true).order("created_at DESC").paginate(:page => params[:page], :per_page => ARTICLES_PER_PAGE)
    end
  end


  def get_article_cats
    @article_cats = ArticleCategory.all(:include => :articles, :conditions => ["articles.published = ?", true])
  end

end
