class ArticleCommentsController < ApplicationController
  def create
		@article = Article.find(params[:article_id])
		@comment = ArticleComment.new(params[:article_comment])
		@comment.active = false
		if @comment.save
			redirect_to article_path(@article), notice: "Your comment was submitted to our review team and should appear shortly."
		else
			redirect_to article_path(@article), alert: "There was an error submitting your comment."
		end
	end
end
