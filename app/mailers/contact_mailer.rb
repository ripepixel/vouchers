class ContactMailer < ActionMailer::Base
  default from: "contact@redhotvoucherbook.com", to: "contact@redhotvoucherbook.com"

  def contact (sender, subject, message, name, business_name, telephone, sent_at = Time.now)
      @sender = sender
      @message = message
      @name = name
      @business_name = business_name
      @telephone = telephone
      @sent_at = sent_at.strftime("%B %e, %Y at %H:%M")
      mail(:from => @sender, :subject => subject)
  end
  
  def advert_enquiry (sender, subject, message, name, business_name, telephone, town, size, sent_at = Time.now)
      @sender = sender
      @message = message
      @name = name
      @business_name = business_name
      @town = town
      @telephone = telephone
      @size = size
      @sent_at = sent_at.strftime("%B %e, %Y at %H:%M")
      mail(:from => @sender, :subject => subject)
  end
  
  def change_password(to, pass)
    @pass = pass
  	@subject = "Password Changed on Red Hot Voucher Books"
  	mail(:to => to, :subject => @subject)
  end
  
  def reset_password(to, new_pass)
  	@subject = "Password Reset on Red Hot Voucher Books"
  	@new_pass = new_pass
  	mail(:to => to, :subject => @subject)
  end
  
  def new_business_profile(business)
    subject = "New Business Created"
    @business = business
    mail(:subject => subject)
  end
  
  def notify_admin_advert_comment(advert, business, from, message)
    @advert = Advert.find(advert)
    @business = BusinessAccount.find(business)
    @message = message
    subject = "New Message Received From Business Advert"
    mail(:from => from, :subject => subject)
  end
  
  def notify_business_advert_comment(to, message)
    subject = "New Message Received"
    @message = message
    mail(:to => to, :subject => subject)
  end
  
  def notify_admin_advert_accepted(ad, business, from)
    @advert = AdvertComment.find(ad)
    @business = BusinessAccount.find(business)
    subject = "A booklet advert design has been accepted"
    mail(:subject => subject, :from => from)
  end
  
  def newsletter_welcome(to)
    @email = to
    subject = "Welcome to the Red Hot Voucher Book Newsletter"
    mail(:subject => subject, :to => to)
  end
  
  def newsletter_welcome_back(to)
    @email = to
    subject = "Welcome back to the Red Hot Voucher Book Newsletter"
    mail(:subject => subject, :to => to)
  end
  
  def new_business_account_password(email, pass)
    @email = email
    @pass = pass
    subject = "Your new Red Hot Voucher Book Account"
    mail(:subject => subject, :to => email)
  end

  def marketing_email(email)
    subject = "New Website Launch - Red Hot Voucher Book"
    mail(:subject => subject, :to => email)
  end

  def new_booklet_advert_request(business, booklet, advert)
    @business = Business.find(business)
    @booklet = Booklet.find(booklet)
    @advert = Advert.find(advert)
    subject = "New booklet advert request"
    mail(:subject => subject)
  end

  
end
