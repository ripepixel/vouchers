module WebVouchersHelper

	def get_web_voucher_views(id)
		views = WebVoucherAnalytics.where('web_voucher_id = ? AND viewed = ?', id, true)
		views.count
	end

	def get_web_voucher_prints(id)
		views = WebVoucherAnalytics.where('web_voucher_id = ? AND printed = ?', id, true)
		views.count
	end
	
	def has_expired?(id)
	 wv = WebVoucher.find(id)
	 if wv.expiry_date < Date.today
	   true
	 else
	   false
	 end
	end

end
