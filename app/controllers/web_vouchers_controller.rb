class WebVouchersController < ApplicationController

before_filter :get_categories
before_filter :authorise_business, only: [:new, :create, :expire_voucher]
before_filter :authenticate_admin_user!, only: [:destroy]


  def index
    @page_title = WV_INDEX_TITLE
    @meta_desc = WV_INDEX_META_DESC
    @meta_key = WV_INDEX_META_KEY
    @web_vouchers = WebVoucher.search(params[:search]).not_expired.has_paid.order("featured DESC, created_at DESC").paginate(:page => params[:page], :per_page => VOUCHERS_PER_PAGE)
  end
  
  def show
  	@voucher = WebVoucher.find_by_url(params[:id])

    @page_title = @voucher.title
    @meta_desc = @voucher.details
    @meta_key = WV_SHOW_META_KEY

    @others = WebVoucher.where("business_account_id = ? AND id != ? AND status = ?", @voucher.business_account_id, @voucher.id, 'Paid').not_expired.limit(3)
    WebVoucherAnalytics.create(web_voucher_id: @voucher.id, viewed: true, remote_ip: request.remote_ip)
  end

  def by_category
    @featured = get_featured_vouchers('business_category_id').not_expired.has_paid
  	@vouchers = WebVoucher.exclude_featured.where("business_category_id = ?", params[:id]).not_expired.has_paid.order("created_at DESC")
    @bus_cat = BusinessCategory.find(params[:id])
    @page_title = "#{@bus_cat.name} Vouchers to print or use online"
  	if @vouchers.empty? && @featured.empty?
  		redirect_to root_url, alert: "Sorry, there are no vouchers in that category"
  	end
  end

  def by_town
    @featured = get_featured_vouchers('town_id').not_expired.has_paid
  	@vouchers = WebVoucher.exclude_featured.where("town_id = ?", params[:id]).not_expired.has_paid.order("created_at DESC")
  	@page_title = "Vouchers in #{@vouchers.first.town.name}" if @vouchers.any?
  	if @vouchers.empty?
  		redirect_to root_url, notice: "Sorry, there are no vouchers in that town"
  	end
  end

  def print
    @voucher = WebVoucher.find_by_url(params[:id])
    WebVoucherAnalytics.create(web_voucher_id: @voucher.id, printed: true, remote_ip: request.remote_ip)
    render :layout => false
  end
  
  
  # Business Accounts Only Below

  def new
    @web_voucher = WebVoucher.new
  end

  def create
    @web_voucher = WebVoucher.new(params[:web_voucher])
    @web_voucher.business_account_id = current_business.id
    @web_voucher.status = 'Pending' # set status to pending until paid
    @web_voucher.town = @web_voucher.business.town

    if @web_voucher.start_date < Date.today
      flash.now[:alert] = "The start date has to be today or later"
    end
      
      # voucher = WebVoucher.where('business_account_id = ?', current_business.id)
      # if voucher.any?
        
        # check if they have any credits
        credits = WebVoucherCredit.where('business_account_id = ?', current_business.id)
        if credits.first.credits > 0
        
          # deduct 1 from credit
          credit_qty = credits.first.credits - 1
          credits.first.update_attributes(credits: credit_qty)
          @web_voucher.status = 'Paid'
          if @web_voucher.save
            redirect_to business_web_vouchers_path, notice: 'Your Voucher has been created.'
          else
            render 'new'
          end
          
        else
          
          # They need to pay for this one
          if @web_voucher.save
            # Paypal
            notify_url = paypal_payments_url
            return_url = business_wv_payment_accepted_url
            cancel_url = business_wv_payment_cancelled_url
            values = {
              :business => PAYPAL_EMAIL_ADDRESS,
              :cmd => '_xclick',
              :upload => 1,
              :notify_url => notify_url,
              :return => return_url,
              :cancel_return => cancel_url,
              :currency_code => 'GBP',
              :invoice => @web_voucher.id,
              :custom => "WV",
              :amount => WEB_VOUCHER_PRICE,
              :item_name => 'Red Hot Voucher Book Web Voucher',
              :quantity => 1
            }
            url = PAYPAL_WEB_URL + values.to_query
            
            redirect_to url
            # GoCardless
            #url_params = {
            #  :redirect_uri => confirm_voucher_payment_url,
            # :amount => WEB_VOUCHER_PRICE,
            #  :name => "Red Hot Voucher - Web Voucher",
            #  :state => @web_voucher.id,
            #  :user => {
            #    :email => current_business.email
            # }
            #}
            # url = GoCardless.new_bill_url(url_params)
        		# redirect_to url
          else
            render 'new'
          end
          
        end
        
      # else
      #         
      #         # This is the first one - its free
      #         @web_voucher.status = 'Paid'
      #         if @web_voucher.save
      #           redirect_to business_web_vouchers_path, notice: 'This Voucher is on us.'
      #         else
      #           render 'new'
      #         end
      #         
      #       end

  end
  
  
  def edit
    @web_voucher = WebVoucher.find_by_id_and_business_account_id(params[:id], current_business.id)
    if @web_voucher.nil?
      redirect_to business_dashboard_path, notice: "That voucher does not exist"
    end
  end
  
  def update
    @web_voucher = WebVoucher.find_by_url(params[:id])
    @web_voucher.update_attributes(params[:web_voucher])
    redirect_to business_web_vouchers_path, notice: "The Web Voucher has been updated"
  end
  
  def expire_voucher
    @web_voucher = WebVoucher.find_by_id_and_business_account_id(params[:id], current_business.id)
    if @web_voucher
      @web_voucher.update_attributes(:expiry_date => (Date.today - 1.day) )
      redirect_to business_web_vouchers_path, notice: "The Web Voucher has been expired"
    else
      flash.now[:error] = "There was an error expiring your voucher"
      redirect_to business_web_vouchers_path
    end
    
  end
  
  
  
  
  # ADMIN ONLY
  def destroy
    @web_voucher = WebVoucher.find(params[:id])
    @web_voucher.destroy
    redirect_to manager_web_vouchers_path, notice: "The web voucher has been deleted"
  end
  

  

end
