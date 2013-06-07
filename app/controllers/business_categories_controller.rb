class BusinessCategoriesController < ApplicationController
  before_filter :authenticate_admin_user!
  
  def edit
    @business_category = BusinessCategory.find(params[:id])
  end
  
  def update
    @business_category = BusinessCategory.find(params[:id])
    if @business_category.update_attributes(params[:business_category])
      redirect_to manager_business_categories_path, notice: 'The business category has been updated'
    else
      render 'edit'
    end
  end
  
  def destroy
    @business_category = BusinessCategory.find(params[:id])
    if @business_category.destroy
      redirect_to manager_business_categories_path, notice: 'The business category has been deleted'
    else
      redirect_to manager_business_categories_path, alert: 'There was an error deleting the business category. It probably has businesses assigned to it'
    end
  end
  
end
