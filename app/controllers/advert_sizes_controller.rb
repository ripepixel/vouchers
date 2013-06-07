class AdvertSizesController < ApplicationController
  before_filter :authenticate_admin_user!
  
  def edit
    @advert_size = AdvertSize.find(params[:id])
  end
  
  def update
    @advert_size = AdvertSize.find(params[:id])
    if @advert_size.update_attributes(params[:advert_size])
      redirect_to manager_advert_sizes_path, notice: 'The advert size has been updated'
    else
      render 'edit'
    end
  end
  
  def destroy
    @advert_size = AdvertSize.find(params[:id])
    if @advert_size.destroy
      redirect_to manager_advert_sizes_path, notice: 'The advert size has been deleted'
    else
      redirect_to manager_advert_sizes_path, alert: 'There was an error deleting the advert size. It probably has adverts assigned to it'
    end
  end
end
