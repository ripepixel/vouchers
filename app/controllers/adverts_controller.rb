class AdvertsController < ApplicationController
  
  before_filter :authorise_business, only: [:pay_advert, :invoice, :print]
  before_filter :authenticate_admin_user!, only: [:new, :create]
  
  def show
    @page_title = "View your booklet voucher"
    @advert_comment = AdvertComment.new
    # if admin logged in get by id
    if admin_user_signed_in?
      @advert = Advert.find(params[:id])
    else
      @advert = Advert.where("id = ? AND business_id = ?", params[:id], current_business.business.id).first
    end
    
    if @advert
      @comments = AdvertComment.where("advert_id = ?", @advert.id).order('created_at DESC')
    else
      redirect_to business_dashboard_path, notice: "Sorry, that Voucher does not exist"
    end
  end
    
  def pay_advert
    advert = Advert.find(params[:id])
    # Paypal
            notify_url = paypal_payments_url
            return_url = business_ad_payment_accepted_url
            cancel_url = business_ad_payment_cancelled_url
            values = {
              :business => PAYPAL_EMAIL_ADDRESS,
              :cmd => '_xclick',
              :upload => 1,
              :notify_url => notify_url,
              :return => return_url,
              :cancel_return => cancel_url,
              :currency_code => 'GBP',
              :invoice => advert.id,
              :custom => "AD",
              :amount => advert.advert_cost,
              :item_name => 'Red Hot Voucher Book Advertisement',
              :quantity => 1
            }
            url = PAYPAL_WEB_URL + values.to_query
            
            redirect_to url
  end
  
  def invoice
    @advert = Advert.find(params[:id])
  end
  
  def print
    @advert = Advert.find(params[:id])
    render :layout => false
  end
  
  # Admin Only
  
  def new
    @advert = Advert.new
  end
  
  def create
    @advert = Advert.new(params[:advert])
    @advert.paid = false
    if @advert.save
      redirect_to booklet_path(@advert.booklet_id), notice: "The advert has been created"
    else
      render 'new'
    end
  end
  
  def destroy
    @advert = Advert.find(params[:id])
    @advert.destroy
    redirect_to booklet_path(@advert.booklet_id), notice: "The advert has been deleted"
  end
  
end
