class Booklet < ActiveRecord::Base
  attr_accessible :month, :name, :town_id, :year, :cut_off_date, :start_date, :expired

  belongs_to :town
  has_many :adverts
  
  def total_pages
    adverts.to_a.sum { |item| item.total_units }
  end
  
  def expected_income
    adverts.to_a.sum { |item| item.advert_cost }
  end

  def current_income
  	adverts.sum(:advert_cost, :conditions => ['paid = ?', true])
  end


end
