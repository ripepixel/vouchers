module AdvertsHelper
  
  def has_been_accepted(ad)
    ac = AdvertComment.where("advert_id = ? AND accepted = ?", ad, true)
    if ac.any?
      true
    else
      false
    end
  end
  
end
