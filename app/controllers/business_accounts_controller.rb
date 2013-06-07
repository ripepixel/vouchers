class BusinessAccountsController < ApplicationController

before_filter :authorise_business, except: [:new, :create]

def new
  @page_title = BA_NEW_PAGE_TITLE
  @meta_desc = BA_NEW_META_DESC
  @meta_key = BA_NEW_META_KEY
  @business_account = BusinessAccount.new
end

def create
  @business_account = BusinessAccount.new(params[:business_account])
  if @business_account.save
    session[:business_id] = @business_account.id
    redirect_to business_dashboard_path
  else
    render "new"
  end
end

def change_password
  @page_title = "Change your password"
end

def send_change_password
  @old_pass = params[:old_pass]
  @new_pass = params[:new_pass]
  @business = BusinessAccount.find(current_business.id)
  
  if @old_pass.empty? || @new_pass.empty?
    flash.now[:error] = "Please complete all fields"     
    render 'change_password' and return
  end
  if @new_pass.length < 6
    flash.now[:error] = "New password must be longer that 6 characters"     
    render 'change_password' and return
  elsif @business.authenticate(@old_pass)
    @business.update_attributes(:password => @new_pass)
    # send email
    ContactMailer.change_password(@business.email, @new_pass).deliver

    # log user out
    session[:business_id] = nil
    flash[:notice] = "Your password has been reset. Please log back in with your new password."      
    redirect_to business_login_path
  else
    flash.now[:error] = "Your old password is incorrect"     
    render 'change_password'
  end
    
end


end
