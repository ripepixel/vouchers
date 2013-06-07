ActiveAdmin.register Business do
  menu :label => "Business Profiles", parent: 'Businesses'
  
  controller do
    defaults :finder => :find_by_business_name
  end
end
