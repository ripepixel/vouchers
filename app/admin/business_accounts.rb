ActiveAdmin.register BusinessAccount do
  menu :label => "Business Accounts", parent: 'Businesses'    
    index do
      column :id
      column :email            
      default_actions                   
    end                                 

    filter :email                       

    form do |f|                         
      f.inputs "Business Details" do       
        f.input :email                   
        f.input :password               
        f.input :password_confirmation

      end                               
      f.buttons                         
    end
    
    def to_s
      self.business.business_name
    end
end
