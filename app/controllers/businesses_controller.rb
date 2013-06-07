class BusinessesController < ApplicationController
  protect_from_forgery :except => :web_vouchers
	before_filter :authorise_business, except: [:index, :show, :directory, :process_review, :search]
	

  def index
    @page_title = BUS_INDEX_PAGE_TITLE
    @meta_desc = BUS_INDEX_META_DESC
    @meta_key = BUS_INDEX_META_KEY

    @businesses = Business.all
  end

  def directory
    @businesses = Business.order('business_name ASC').paginate(:page => params[:page], :per_page => BUSINESSES_PER_PAGE)

    @page_title = BUS_INDEX_PAGE_TITLE
    @meta_desc = BUS_INDEX_META_DESC
    @meta_key = BUS_INDEX_META_KEY
  end

  def search
    @businesses = Business.search(params[:what], params[:where]).paginate(:page => params[:page], :per_page => BUSINESSES_PER_PAGE)
  end

  def show
    @business = Business.find_by_business_name(params[:id])
    if @business.nil?
      redirect_to business_directory_path, alert: "Sorry, that business does not exist"
    else
    
      @page_title = "#{@business.business_name} in #{@business.town}"
      @meta_desc = BUS_INDEX_META_DESC
      @meta_key = BUS_INDEX_META_KEY

        
      @vouchers = WebVoucher.where('business_account_id = ? AND status = ?', @business.business_account_id, 'Paid').order('created_at DESC')
      @reviews = BusinessReview.where('business_id = ? AND published = ? AND active = ?', @business.id, true, true).order('created_at DESC')
      @rating = @reviews.collect(&:rating).sum.to_f/@reviews.length if @reviews.length > 0  
    
    end
  end

  def new
  	@business = Business.find_by_business_account_id(current_business.id)
  	if(@business.blank?)
  		@business = Business.new
  	else
  		render "edit"
  	end
  	
  end

  def process_review
    @review = BusinessReview.new(business_id: params[:business_id], email: params[:email], name: params[:name], rating: params[:rating], comments: params[:comments], published: false, active: false)
    if @review.save
      redirect_to business_path(@review.business.business_name), notice: "Thanks. Your review has been submitted and will appear shortly."
    else
      redirect_to business_path(@review.business.business_name), alert: "There was a problem adding your review, please try again"
    end
  end

  def create
  	@business = Business.new(params[:business])
  	@business.business_account_id = current_business.id
  	if @business.save
  	  # Add voucher credits to their account
  	  WebVoucherCredit.create(business_account_id: current_business.id, credits: FREE_CREDIT_AMOUNT)
  	  ContactMailer.new_business_profile(@business).deliver
  		redirect_to business_dashboard_path, notice: "Thanks, your business profile has been created. You have been credited with #{FREE_CREDIT_AMOUNT} free credits to create web vouchers; enjoy!"
  	else
  		flash.now[:error] = "There were problems creating your profile"
  		render "new"
  	end
  end

  def edit
  	@business = Business.find_by_business_account_id(current_business.id)
  	if(@business.blank?)
  		redirect_to new_business_path
  	else
  		render "edit"
  	end
  end

  def update
  	@business = Business.find_by_business_account_id(current_business.id)
  	if @business.update_attributes(params[:business])
  		redirect_to business_dashboard_path, notice: "Thanks, your business profile has been updated."
  	else
  		render "edit"
  	end
  end

  def dashboard
  	@business = Business.find_by_business_account_id(current_business.id)
    if(@business.blank?)
      redirect_to new_business_path, notice: "Please set up your business profile."
    else
      @latest_adverts = Advert.where('business_id = ?', current_business.business.id).order('created_at DESC').limit(3)
  	  @latest_web_vouchers = WebVoucher.where('business_account_id = ? AND status = ?', current_business, 'Paid').order('created_at DESC').limit(3)
  	  @credits = WebVoucherCredit.find_by_business_account_id(current_business)
	  end
  end
  
  def adverts
    @adverts = Advert.where('business_id = ?', current_business.business).paginate(:page => params[:page], :per_page => BUSINESS_ADMIN_VOUCHERS_PER_PAGE)
  end

  def web_vouchers
    @adverts = WebVoucher.where('business_account_id = ? AND status = ?', current_business, 'Paid').order('created_at DESC').paginate(:page => params[:page], :per_page => BUSINESS_ADMIN_VOUCHERS_PER_PAGE)
    @credits = WebVoucherCredit.find_by_business_account_id(current_business)
      
  end

  def wv_payment_accepted
    redirect_to business_web_vouchers_path, notice: "Thanks for your purchase, your web voucher has been created"
  end

  def wv_payment_cancelled
    redirect_to business_web_vouchers_path, alert: "Your purchase was cancelled :( If there was a problem, please let us know."
  end

  def ad_payment_accepted
    redirect_to business_adverts_path, notice: "Thanks for your payment."
  end

  def ad_payment_cancelled
    redirect_to business_adverts_path, alert: "Your payment has been cancelled. Your advert requires payment before it is printed in the booklet. Please contact us if you have any issues."
  end

  def new_book_advert
    @advert = Advert.new
  end

  def create_book_advert
    @advert = Advert.new(:booklet_id => params[:booklet_id], :advert_size_id => params[:advert_size_id])
    @advert.business_id = current_business.business.id

    if @advert.save
      # send email to admin regarding new request
      ContactMailer.new_booklet_advert_request(current_business.business, @advert.booklet_id, @advert).deliver
      redirect_to business_dashboard_path, notice: "Your booklet voucher request has been accepted. You will be contacted shortly regarding your requirements."
    else
      redirect_to business_dashboard_path, alert: "There was a problem creating your voucher advertisement. Please contact us."
    end
  end

  def my_events
    @events = Event.where('business_id = ?', current_business.business.id).order('date_to DESC').paginate(:page => params[:page], :per_page => 10)
  end
  
end
