class PaypalPaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  
  def create
  	if params[:custom] == "WV"
  		WebVoucherPayments.create!(:params => params, :web_voucher_id => params[:invoice], :status => params[:payment_status], :txn_id => params[:txn_id])
  		wv = WebVoucher.find(params[:invoice])
  		wv.update_attributes(status: "Paid")
  	elsif params[:custom] == "AD" 
  		AdvertPayments.create!(:params => params, :advert_id => params[:invoice], :status => params[:payment_status], :txn_id => params[:txn_id])
  		ad = Advert.find(params[:invoice])
  		ad.update_attributes(paid: true)
  	end
    render :nothing => true
  end


end
