class ManagerController < ApplicationController
  
	before_filter :authenticate_admin_user!
  helper_method :commission_rate

  def index
  	# not really needed - will redirect to active admin login page
  	redirect_to manager_dashboard_path
  end

  def dashboard
    if current_admin_user.auth_level == "full"
      @businesses = BusinessAccount.count
      @profiles = Business.count
      @web_vouchers = WebVoucher.not_expired.has_paid.count
      @reviews = BusinessReview.all
    else
      redirect_to appointments_path
    end
  end
  
  def booklets
    @current_booklets = Booklet.where('start_date > ?', Date.today).order('created_at DESC')
    @past_booklets = Booklet.where('start_date < ?', Date.today).order('created_at DESC')
  end

  def set_advert_paid
    @advert = Advert.find(params[:advert])
    @advert.update_attributes(paid: true)
    redirect_to booklet_path(params[:booklet]), notice: "The advert payment status has been changed"
  end
  
  def businesses
    @businesses = Business.order('business_name ASC').paginate(:page => params[:page], :per_page => 20)
  end

  def business_reviews
    @reviews = BusinessReview.order('created_at DESC')
  end

  def edit_review
    @review = BusinessReview.find(params[:id])
  end

  def update_review
    @review = BusinessReview.find(params[:business_review][:id])
    
    if @review.update_attributes(params[:business_review])
      redirect_to manager_business_reviews_path, notice: "The review has been updated"
    else
      redirect_to manager_business_reviews_path, alert: "There was an error updating the review"
    end
  end
  
  def web_vouchers
    @vouchers = WebVoucher.order('expiry_date DESC').paginate(:page => params[:page], :per_page => 20)
  end
  
  def settings
    
  end
  
  def towns
    @towns = Town.all
  end
  
  def business_categories
    @business_categories = BusinessCategory.all
  end
  
  def advert_sizes
    @advert_sizes = AdvertSize.all
  end
  
  def add_credits
    @credits = WebVoucherCredit.find_by_business_account_id(params[:id])
  end

  def update_credits
    @credits = WebVoucherCredit.find_by_business_account_id(params[:bus_id])
    if @credits
      new_total = @credits.credits + params[:credits].to_i
      @credits.update_attributes(credits: new_total)
      redirect_to manager_add_credits_path(id: @credits.business_account_id), notice: 'Credits have been added'
    else
      redirect_to manager_add_credits_path(id: @credits.business_account_id), alert: 'There was a problem adding credits'
    end
  end
  
  def new_business_account
    @business_account = BusinessAccount.new
  end
  
  def create_business_account
    random_password = (0...8).map{ ('a'..'z').to_a[rand(26)] }.join
    @business_account = BusinessAccount.new(email: params[:email], password: random_password, password_confirmation: random_password)
    if @business_account.save
      ContactMailer.new_business_account_password(params[:email], random_password).deliver
      if params[:contact_id]
        redirect_to manager_new_business_profile_path(id: @business_account.id, contact_id: params[:contact_id]), notice: "Please check the contact details are correct"
      else
        redirect_to manager_new_business_profile_path(id: @business_account.id), notice:"The business account has been created. Please add the business details." and return
      end
    else
      redirect_to manager_dashboard_path, alert:"There was a problem creating the business account"
    end
  end
  
  def new_business_profile
    if params[:contact_id]
      @contact = Contact.find(params[:contact_id])
    else
      @contact = nil
    end
  end
  
  def create_business_profile
    @profile = Business.new(business_account_id: params[:business_account_id], business_name: params[:business_name],
                            business_category_id: params[:business_category_id], street: params[:street], town: params[:town], 
                            county: params[:county], postcode: params[:postcode], telephone: params[:telephone], 
                            website: params[:website])
    if @profile.save
      # add business_id to contact
      if params[:contact_id]
        contact = Contact.find(params[:contact_id])
        contact.update_attributes(business_id: @profile.id)
      end
      # add zero credits
      credits = WebVoucherCredit.create(business_account_id: @profile.business_account_id, credits: 0)
      redirect_to manager_dashboard_path, notice:"The business profile has been created"
    else
      redirect_to manager_dashboard_path, alert:"There was a problem creating the business profile"
    end
  end

  def edit_business_profile
    @business = Business.find(params[:id])
  end

  def update_business_profile
    @business = Business.find(params[:business_account_id])
    img = params[:image].blank? ? @business.image : params[:image]
    
    @business.update_attributes(business_name: params[:business_name], business_category_id: params[:business_category_id], street: params[:street], town: params[:town],
                                county: params[:county], postcode: params[:postcode], telephone: params[:telephone], website: params[:website],
                                image: img, about_us: params[:about_us])

    redirect_to manager_businesses_path, notice: "The business profile has been updated"
  end

  def new_web_voucher
    @web_voucher = WebVoucher.new
  end

  def create_web_voucher
    @bus = Business.find_by_business_account_id(params[:business_account_id])
    @web_voucher = WebVoucher.new(:business_account_id => params[:business_account_id], :title => params[:title], :details => params[:details],
                                  :terms => params[:terms], :start_date => Date.today,
                                  :business_category_id => params[:business_category_id], :status => "Paid", :town => @bus.town)
    if @web_voucher.save
      redirect_to manager_web_vouchers_path, notice: "The web voucher has been created"
    else
      redirect_to manager_web_vouchers_path, alert: "There was a problem creating the web voucher"
    end
  end
  
  def edit_web_voucher
    @web_voucher = WebVoucher.find(params[:id])
  end
  
  def update_web_voucher
    @web_voucher = WebVoucher.find(params[:web_voucher][:id])
    
    if @web_voucher.update_attributes(params[:web_voucher])
      redirect_to manager_web_vouchers_path, notice: "The web voucher has been updated"
    else
      redirect_to manager_web_vouchers_path, alert: "There was an error updating the web voucher"
    end
  end
  
  def expire_web_voucher
    @web_voucher = WebVoucher.find(params[:id])
    if @web_voucher
      @web_voucher.update_attributes(:expiry_date => (Date.today - 1.day) )
      redirect_to manager_web_vouchers_path, notice: "The Web Voucher has been expired"
    else
      redirect_to manager_web_vouchers_path, alert: "There was an error expiring your voucher"
    end
    
  end

  def marketing_email
    
  end

  def send_marketing_email
    @emails = params[:email].split(',')
    @emails.each do |email|
      # Check if email exists
      @existing = MarketingEmail.find_by_email(email)
      if !@existing
        @new_email = MarketingEmail.new(:email => email, :subscribed => true)
        @new_email.save
        ContactMailer.marketing_email(email).deliver
      end
    end

    redirect_to manager_marketing_email_path, notice: 'Emails have been sent'
  end
  
  def articles
    @articles = Article.all
  end
  
  
  # Reports Below Here
  
  def reports
    
  end
  
  def commission_report
    @booklets = Booklet.where('start_date < ?', Date.today)
  end
  
  def commission_by_booklet
    @ads = Advert.where('booklet_id = ?', params[:booklet_id])
    @ads_user = @ads.group_by { |t| t.admin_user.fullname}
    @commissions = Commission.all
  end

  def commission_by_booklet_print
    @ads = Advert.where('booklet_id = ?', params[:booklet_id])
    @ads_user = @ads.group_by { |t| t.admin_user.fullname}
    @commissions = Commission.all
    render :layout => false
  end


  def commission_rate(admin, advert)
    Commission.where('admin_user_id = ? AND advert_size_id = ?', admin, advert)
  end
  
  def create_contacts_from_existing_businesses
    businesses = Business.all
    businesses.each do |bus|
      contact = Contact.new(business_name: bus.business_name, telephone: bus.telephone, street: bus.street, town: bus.town, county: bus.county, postcode: bus.postcode, website: bus.website, business_id: bus.id, do_not_contact: false, business_category_id: bus.business_category_id, email: bus.business_account.email)
      contact.save
    end
  end

  def sign_in_as_business
    business_account = BusinessAccount.find_by_id(params[:id])
    session[:business_id] = business_account.id
    redirect_to business_dashboard_path, notice: "Logged in!"
  end
  
end
