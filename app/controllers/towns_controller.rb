class TownsController < ApplicationController
  before_filter :authenticate_admin_user!
  
  def edit
    @town = Town.find(params[:id])
  end
  
  def update
    @town = Town.find(params[:id])
    if @town.update_attributes(params[:town])
      redirect_to manager_towns_path, notice: 'The town has been updated'
    else
      render 'edit'
    end
  end
  
  def destroy
    @town = Town.find(params[:id])
    if @town.destroy
      redirect_to manager_towns_path, notice: 'The town has been deleted'
    else
      redirect_to manager_towns_path, alert: 'There was an error deleting the town. It probably has booklets assigned to it'
    end
  end
  
end
