class EventsController < ApplicationController
  before_filter :authorise_business, except: [:index, :show]


  def index
  	# events for current month only
  	@events = Event.where('date_from > ? AND date_to <= ? AND active = ?', Date.today.beginning_of_month, Date.today.end_of_month, true).order('date_from ASC')
  end

  def show
  	@event = Event.find(params[:id])
  end

  def new
  	@event = Event.new
  end

  def create
  	@event = Event.new(params[:event])
  	@event.business_id = current_business.business.id
  	if @event.save
  		redirect_to business_my_events_path, notice: "Thanks. Your event has been added and will be displayed shortly."
  	else
  		flash.now[:error] = "There was an error adding your event"
      	redirect_to business_my_events_path
  	end
  end

  def edit
  	@event = Event.where('business_id = ?', current_business.business.id).find(params[:id])
  	if @event
  		render 'edit'
  	else
  		redirect_to business_my_events_path, alert: 'Sorry, that event does not exist'
  	end
  end

  def update
  	@event = Event.where('business_id = ?', current_business.business.id).find(params[:id])
  	if @event.update_attributes(params[:event])
  		redirect_to business_my_events_path, notice: "Thanks. Your event has been updated."
  	else
		flash.now[:error] = "There was an error updating your event"
      	render 'edit'
  	end
  end
end
