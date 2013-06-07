class CommissionsController < ApplicationController
  def index
  	@commissions = Commission.where('active = ?', true)
  end

  def new
  	@commission = Commission.new
  end

  def create
  	@commission = Commission.new(params[:commission])
  	@commission.active = true
  	if @commission.save
  		redirect_to commissions_path, notice: 'The commission rate has been saved'
  	else
  		render 'new'
  	end
  end

  def edit
	@commission = Commission.find(params[:id])
  end

  def update
  	@commission = Commission.find(params[:id])
    if @commission.update_attributes(params[:commission])
      redirect_to commissions_path, notice: 'The commission rate has been updated'
    else
      render 'edit'
    end
  end
  
  def destroy
    @commission = Commission.find(params[:id])
    @commission.active = false
    if @commission.save
      redirect_to commissions_path, notice: 'The commission rate has been deleted'
    else
      redirect_to commissions_path, alert: 'There was an error deleting the commissions rate'
    end
  end
end
