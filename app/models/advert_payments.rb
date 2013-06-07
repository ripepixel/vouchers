class AdvertPayments < ActiveRecord::Base
  attr_accessible :advert_id, :params, :status, :txn_id
end
