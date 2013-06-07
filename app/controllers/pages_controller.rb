class PagesController < ApplicationController
  before_filter :get_categories, :get_featured_web_vouchers, :get_towns

  def index
    @page_title = PAGES_INDEX_TITLE
    @meta_desc = PAGES_INDEX_META_DESC
    @meta_key = PAGES_INDEX_META_KEY

  	@vouchers = WebVoucher.exclude_featured.where("start_date < ? AND expiry_date > ?", Date.today, Date.today).order("created_at DESC")
  end

  def contact
    @page_title = PAGES_CONTACT_TITLE
    @meta_desc = PAGES_CONTACT_META_DESC
    @meta_key = PAGES_CONTACT_META_KEY

    @name = ''
    @business_name = ''
    @email = ''
    @telephone = ''
    @message = ''
  end
  
  def send_contact_form
    @name = params[:name]
    @business_name = params[:business_name]
    @telephone = params[:telephone]
    @sender = params[:email]
    @subject = "Email from contact form"
    @message = params[:message]
    if validate(@sender, @subject, @message)
      ContactMailer.contact(@sender, @subject, @message, @name, @business_name, @telephone).deliver      
      flash[:notice] = "Your message has been sent. We will reply as soon as possible."      
      redirect_to contact_path
    else
      flash.now[:error] = @error     
      render 'contact'
    end
  end
  
  def advert_enquiry
    @page_title = PAGES_ADVERT_ENQUIRY_TITLE
    @meta_desc = PAGES_ADVERT_ENQUIRY_META_DESC
    @meta_key = PAGES_ADVERT_ENQUIRY_META_KEY
        
    @name = ''
    @business_name = ''
    @town = ''
    @email = ''
    @telephone = ''
    @message = ''
    @size = ''
  end
  
  def send_advert_enquiry
    @name = params[:name]
    @business_name = params[:business_name]
    @telephone = params[:telephone]
    @town = params[:town]
    @size = params[:size]
    @sender = params[:email]
    @subject = "Business Advert Enquiry"
    @message = params[:message]
    
    if validate(@sender, @subject, @message)
      ContactMailer.advert_enquiry(@sender, @subject, @message, @name, @business_name, @telephone, @town, @size).deliver      
      flash[:notice] = "Your message has been sent. We will contact you shortly."      
      redirect_to advert_enquiry_path
    else
      flash.now[:error] = @error     
      render 'advert_enquiry'
    end
  end


  def advertising
    @page_title = PAGES_ADVERTISING_TITLE
    @meta_desc = PAGES_ADVERTISING_META_DESC
    @meta_key = PAGES_ADVERTISING_META_KEY
  end

  def privacy_policy
    @page_title = "Red Hot Voucher Book Privacy Policy"
  end

  def terms
    @page_title = "Red Hot Voucher Book Terms & Conditions"
  end

  def restaurant_vouchers
    @featured = get_featured_vouchers(8).not_expired.has_paid
    @vouchers = WebVoucher.exclude_featured.where("business_category_id = ?", 8).not_expired.has_paid.order("created_at DESC")
    @bus_cat = BusinessCategory.find(8)
    @page_title = "#{@bus_cat.name} Vouchers to print or use online"
    if @vouchers.empty? && @featured.empty?
      redirect_to root_url, alert: "Sorry, there are no vouchers in that category"
    end
  end

  def health_and_beauty_vouchers
    @featured = get_featured_vouchers(5).not_expired.has_paid
    @vouchers = WebVoucher.exclude_featured.where("business_category_id = ?", 5).not_expired.has_paid.order("created_at DESC")
    @bus_cat = BusinessCategory.find(5)
    @page_title = "#{@bus_cat.name} Vouchers to print or use online"
    if @vouchers.empty? && @featured.empty?
      redirect_to root_url, alert: "Sorry, there are no vouchers in that category"
    end
  end

  def bars_vouchers
    @featured = get_featured_vouchers(1).not_expired.has_paid
    @vouchers = WebVoucher.exclude_featured.where("business_category_id = ?", 1).not_expired.has_paid.order("created_at DESC")
    @bus_cat = BusinessCategory.find(1)
    @page_title = "#{@bus_cat.name} Vouchers to print or use online"
    if @vouchers.empty? && @featured.empty?
      redirect_to root_url, alert: "Sorry, there are no vouchers in that category"
    end
  end

  def takeaway_vouchers
    @featured = get_featured_vouchers(4).not_expired.has_paid
    @vouchers = WebVoucher.exclude_featured.where("business_category_id = ?", 4).not_expired.has_paid.order("created_at DESC")
    @bus_cat = BusinessCategory.find(4)
    @page_title = "#{@bus_cat.name} Vouchers to print or use online"
    if @vouchers.empty? && @featured.empty?
      redirect_to root_url, alert: "Sorry, there are no vouchers in that category"
    end
  end

  def motoring_vouchers
    @featured = get_featured_vouchers(3).not_expired.has_paid
    @vouchers = WebVoucher.exclude_featured.where("business_category_id = ?", 3).not_expired.has_paid.order("created_at DESC")
    @bus_cat = BusinessCategory.find(3)
    @page_title = "#{@bus_cat.name} Vouchers to print or use online"
    if @vouchers.empty? && @featured.empty?
      redirect_to root_url, alert: "Sorry, there are no vouchers in that category"
    end
  end

  def fashion_vouchers
    @featured = get_featured_vouchers(11).not_expired.has_paid
    @vouchers = WebVoucher.exclude_featured.where("business_category_id = ?", 11).not_expired.has_paid.order("created_at DESC")
    @bus_cat = BusinessCategory.find(11)
    @page_title = "#{@bus_cat.name} Vouchers to print or use online"
    if @vouchers.empty? && @featured.empty?
      redirect_to root_url, alert: "Sorry, there are no vouchers in that category"
    end
  end



  private
      def validate(sender, subject, message)
        @email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        if sender.blank? || subject.blank? || message.blank?
          @error = "Message not sent: Please enter all required information."
          return false
        elsif sender[@email_regex].nil?
          @error = "Message not sent: Email not valid"
          return false
        else
          return true
        end
      end


end
