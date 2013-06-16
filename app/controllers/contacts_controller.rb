class ContactsController < ApplicationController
  before_filter :authenticate_admin_user!
  
  def index
    if current_admin_user.auth_level == 'full'
      @contacts = Contact.order('business_name ASC').paginate(:page => params[:page], :per_page => 20)
    else
      @contacts = Contact.where("do_not_contact = ?", false).order('business_name ASC').paginate(:page => params[:page], :per_page => 20)
    end
  end

  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(params[:contact])
    @contact.do_not_contact = false
    if @contact.save
      redirect_to contacts_path, notice: "Contact has been created successfully"
    else
      flash.now['alert'] = "There was a problem saving the contact"
      render 'new'
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end
  
  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      redirect_to contacts_path, notice: "Contact has been updated successfully"
    else
      render 'edit'
    end
  end

  def show
    @contact = Contact.find(params[:id])
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.do_not_contact = true
    @contact.save
    
    redirect_to contacts_path, notice: "The contact has been deleted"
  end
  
  def totally_delete_contact
    contact = Contact.find(params[:contact_id])
    contact.destroy
    redirect_to contacts_path, notice: "Contact has been permanently deleted"
  end
  
  def create_a_business_listing
    contact = Contact.find(params[:contact_id])
    if contact.email.empty?
      redirect_to manager_new_business_account_path(contact_id: contact.id)
    else
      redirect_to manager_create_business_account_path(email: contact.email, contact_id: contact) and return
    end 
  end
end
