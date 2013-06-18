class TestimonialsController < ApplicationController
  def index
  	@testimonials = Testimonial.where("active = ?", true).order("RAND()").limit(6)
  	@testimonial = Testimonial.new
  end


  def create
  	@testimonial = Testimonial.new(params[:testimonial])
  	@testimonial.active = false
  	if @testimonial.save
  		redirect_to testimonials_path, notice: "Thanks. Your testimonial will be displayed shortly."
  	else
  		redirect_to testimonials_path, alert: "Sorry, there was a problem saving your submission."
  	end
  end

end
