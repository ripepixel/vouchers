ActiveAdmin.register WebVoucher do
  
  controller do
    defaults :finder => :find_by_url
  end
  
end
