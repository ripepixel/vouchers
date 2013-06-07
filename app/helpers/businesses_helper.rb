module BusinessesHelper

	def rating_display(score)
  	if score == 0
  		disp =  "<i class='icon-star-empty'></i> <i class='icon-star-empty'></i> <i class='icon-star-empty'></i> <i class='icon-star-empty'></i> <i class='icon-star-empty'></i>"
  	elsif score == 1
  		disp =  "<i class='icon-star'></i> <i class='icon-star-empty'></i> <i class='icon-star-empty'></i> <i class='icon-star-empty'></i> <i class='icon-star-empty'></i>"
  	elsif score == 2
  		disp =  "<i class='icon-star'></i> <i class='icon-star'></i> <i class='icon-star-empty'></i> <i class='icon-star-empty'></i> <i class='icon-star-empty'></i>"
  	elsif score == 3
  		disp =  "<i class='icon-star'></i> <i class='icon-star'></i> <i class='icon-star'></i> <i class='icon-star-empty'></i> <i class='icon-star-empty'></i>"
  	elsif score == 4
  		disp =  "<i class='icon-star'></i> <i class='icon-star'></i> <i class='icon-star'></i> <i class='icon-star'></i> <i class='icon-star-empty'></i>"
  	else score == 5
  		disp =  "<i class='icon-star'></i> <i class='icon-star'></i> <i class='icon-star'></i> <i class='icon-star'></i> <i class='icon-star'></i>"
  	end
  end

end
