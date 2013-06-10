class AppointmentsController < ApplicationController
  before_filter :authenticate_admin_user!
  
  def index
    if current_admin_user.auth_level == "full"
      @appointments = Appointment.where('appointment_time between ? AND ?', Date.today.beginning_of_day, Date.today.end_of_day).order('appointment_time ASC')
    	@future = Appointment.where('appointment_time > ? AND appointment_time < ?', Date.today+1.day, Date.today+5.days).order('appointment_time ASC').limit(10)
    else
      @appointments = Appointment.where('admin_user_id = ? AND appointment_time between ? AND ?', current_admin_user.id, Date.today.beginning_of_day, Date.today.end_of_day).order('appointment_time ASC')
    	@future = Appointment.where('admin_user_id = ? AND appointment_time > ? AND appointment_time < ?', current_admin_user.id, Date.today+1.day, Date.today+5.days).order('appointment_time ASC').limit(10)
    end
  	
  end

  def show
  	@appointments = Appointment.where('admin_user_id = ?', params[:id]).order('appointment_time ASC')
  end

  def new
  	@appointment = Appointment.new
  end

  def create
  	@appointment = Appointment.new(params[:appointment])
  	# @appointment.admin_user_id = current_admin_user.id

  	if @appointment.save
  		redirect_to appointments_path, notice: "The appointment has been saved"
  	else
  		flash.now[:alert] = "There was a problem saving the appointment"
      	render 'new'
  	end
  end

  def edit
  	@appointment = Appointment.find(params[:id])
  end

  def update
  	@appointment = Appointment.find(params[:id])
  	if @appointment.update_attributes(params[:appointment])
  		redirect_to appointments_path, notice: "The appointment has been updated"
  	else
  		flash.now[:alert] = "There was a problem saving the appointment"
      	render 'edit'
  	end

  end


end
