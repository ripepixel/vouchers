class NewslettersController < ApplicationController
  def new
  end
  
  def create
    # see if already was a subscriber
    @account = Newsletter.find_by_email(params[:email])
    if @account
      @account.update_attributes(subscribed: true)
      ContactMailer.newsletter_welcome_back(@newsletter.email).deliver
      redirect_to root_url, notice: "Thanks for subscribing to our newsletter."
    else
      @newsletter = Newsletter.new(email: params[:email], subscribed: true)
    
      if @newsletter.save
        ContactMailer.newsletter_welcome(@newsletter.email).deliver
        redirect_to root_url, notice: "Thanks for subscribing to our newsletter."
      else
        redirect_to root_url, notice: "There was a problem signing you up to the newsletter"
      end
    end
  end
  
  def unsubscribe
    @email = params[:email]
    @account = Newsletter.find_by_email(@email)
    if @account
      @account.update_attributes(subscribed: false, unsubscribed_date: Date.today)
      redirect_to root_url, notice: "You have been unsubscribed from the newsletter :("
    else
      redirect_to root_url, alert: "There was a problem unsubscribing your account. It either does not exists or has already been unsubscribed"
    end
  end
  
end
