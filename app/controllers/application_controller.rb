class ApplicationController < ActionController::Base
  protect_from_forgery


  private
  def current_business
  	@current_business ||= BusinessAccount.find(session[:business_id]) if session[:business_id]
  end
  helper_method :current_business

  def authorise_business
  	redirect_to business_login_url, alert: "Please sign in first" if current_business.nil?
  end

  def get_categories
  	@categories = BusinessCategory.order("name ASC")
  end
  helper_method :get_categories

  def get_towns
    @towns = Town.all
  end
  helper_method :get_towns

  def get_featured_web_vouchers
  	@featured = WebVoucher.where("featured = ? AND start_date < ? AND expiry_date > ?", true, Date.today, Date.today).order("created_at DESC")
  end
  helper_method :get_featured_web_vouchers

  def get_featured_vouchers(row)
  	WebVoucher.where("#{row} = ? AND featured = ? AND start_date < ? AND expiry_date > ?", params[:id], true, Date.today, Date.today).order("created_at DESC")
  end
  helper_method :get_featured_vouchers
  
  def get_all_featured_vouchers
    WebVoucher.where('featured = ? AND start_date < ? AND expiry_date > ?', true, Date.today, Date.today)
  end
  

end
