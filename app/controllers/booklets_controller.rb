class BookletsController < ApplicationController
  
  before_filter :authenticate_admin_user!
  
  def new
    @booklet = Booklet.new
  end
  
  def create
    @booklet = Booklet.new(params[:booklet])
    @booklet.expired = false
    if @booklet.save
      redirect_to manager_booklets_path, notice: "Booklet has been created"
    else
      flash.now[:error] = "There were errors saving the form"
      render "new"
    end
  end
  
  def show
    @booklet = Booklet.find(params[:id])
  end
  
end
