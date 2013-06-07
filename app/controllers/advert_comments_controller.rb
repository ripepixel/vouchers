class AdvertCommentsController < ApplicationController
  def new
  end
  
  def create
    @comment = AdvertComment.new(params[:advert_comment])
    @comment.advert_id = params[:advert_comment][:advert_id]
    # see if admin or business
    if admin_user_signed_in?
      @comment.admin_user_id = current_admin_user.id
      # Send email to business
      ContactMailer.notify_business_advert_comment(@comment.advert.business.business_account.email, @comment.comment).deliver
    else
      @comment.business_account_id = current_business.id
      # Send email to admin
      ContactMailer.notify_admin_advert_comment(params[:advert_comment][:advert_id], current_business.id, current_business.email, @comment.comment).deliver
    end
    
    if @comment.save
      redirect_to advert_path(@comment.advert_id), notice: 'Comment has been added'
    else
      flash.now[:error] = "There was a problem saving your comment"
      redirect_to advert_path(@comment.advert_id)
    end
    
  end
  
  def accept_design
    @comment = AdvertComment.find(params[:id])
    @comment.update_attributes(accepted: true)
    # email admin
    ContactMailer.notify_admin_advert_accepted(@comment.id, current_business.id, current_business.email).deliver
    redirect_to advert_path(@comment.advert_id), notice: "The selected design has been accepted. This design will be added to the book once payment has been received"
  end
  
end
