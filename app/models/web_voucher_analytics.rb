class WebVoucherAnalytics < ActiveRecord::Base
  attr_accessible :printed, :remote_ip, :thumbs_down, :thumbs_up, :viewed, :web_voucher_id

  belongs_to :web_voucher
end
