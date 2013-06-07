class WebVoucherPaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  
  def create
    WebVoucherPayments.create!(:params => params, :web_voucher_id => params[:custom], :status => params[:payment_status], :txn_id => params[:txn_id])
    render :nothing => true
  end
end
