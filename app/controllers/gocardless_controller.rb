class GocardlessController < ApplicationController
  
  def confirm_advert_payment
    begin
      GoCardless.confirm_resource params
      advert = Advert.find(params[:state])
      advert.update_attributes(:paid => true, :resource_id => params[:resource_id])
      redirect_to business_dashboard_path, notice: "Thanks, your advert payment was successful"
    rescue GoCardless::ApiError => e
      @error = e
      redirect_to business_dashboard_path, notice: "There were errors with your payment. Details: #{e}"
    end
  end
  
  def confirm_voucher_payment
    begin
      GoCardless.confirm_resource params
      voucher = WebVoucher.find(params[:state])
      voucher.update_attributes(:status => 'Paid', :resource_id => params[:resource_id])
      redirect_to business_dashboard_path, notice: "Thanks, your web voucher payment was successful"
    rescue GoCardless::ApiError => e
      @error = e
      redirect_to business_dashboard_path, notice: "There were errors with your payment. Details: #{e}"
    end
    
  end
  
end
