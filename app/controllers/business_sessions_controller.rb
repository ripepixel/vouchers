class BusinessSessionsController < ApplicationController
  
def new
  @page_title = BS_NEW_PAGE_TITLE
  @meta_desc = BS_NEW_META_DESC
  @meta_key = BS_NEW_META_KEY
end

def create
  business_account = BusinessAccount.find_by_email(params[:email].downcase)
  if business_account && business_account.authenticate(params[:password])
    session[:business_id] = business_account.id
    redirect_to business_dashboard_path, notice: "Logged in!"
  else
    flash.now.alert = "Email or password is invalid"
    render "new"
  end
end

def destroy
  session[:business_id] = nil
  redirect_to root_url, notice: "Logged out!"
end

def reset_password
  @page_title = BS_RESET_PASSWORD_TITLE
  @meta_desc = BS_RESET_PASSWORD_META_DESC
  @meta_key = BS_RESET_PASSWORD_META_KEY
end

def send_new_password
  # create new password
  new_pass = (0...8).map{ ('a'..'z').to_a[rand(26)] }.join
  if validate_email(params[:email])
    @business = BusinessAccount.find_by_email(params[:email])
    if @business
      # update users password
      @business.update_attributes(:password => new_pass)
      # send email with new password
      ContactMailer.reset_password(params[:email], new_pass).deliver
      flash[:notice] = "Your password has been reset. Please check your email account."      
      redirect_to business_login_path
    else
      flash.now[:error] = "That email address is not on our system"     
      render 'reset_password'
    end
  else
    flash.now[:error] = @error     
    render 'reset_password'
  end
end

private

def validate_email(email)
  @email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    if email.blank? 
      @error = "Please enter an email address."
      return false
    elsif email[@email_regex].nil?
      @error = "Email address not valid"
      return false
    else
      return true
    end
end

end
