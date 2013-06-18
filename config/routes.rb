Myapp::Application.routes.draw do
  
  


  
  get "contact_messages/new"

  get 'business_signup', to: 'business_accounts#new', as: 'business_signup'
  get 'business_login', to: 'business_sessions#new', as: 'business_login'
  get 'business_logout', to: 'business_sessions#destroy', as: 'business_logout'
  
  get 'business_accounts/change_password', to: 'business_accounts#change_password'
  post 'business_accounts/send_change_password', to: 'business_accounts#send_change_password'
  resources :business_accounts
  
  get 'business_sessions/reset_password', to: 'business_sessions#reset_password'
  post 'business_sessions/send_new_password', to: 'business_sessions#send_new_password'
  resources :business_sessions

  get 'business/dashboard', to: 'businesses#dashboard', as: 'business/dashboard'
  get 'business/adverts', to: 'businesses#adverts', as: 'business/adverts'
  match 'business/web_vouchers', to: 'businesses#web_vouchers', via: [:get, :post]
  get 'business/wv_payment_cancelled', to: 'businesses#wv_payment_cancelled'
  get 'business/wv_payment_accepted', to: 'businesses#wv_payment_accepted'
  get 'business/ad_payment_cancelled', to: 'businesses#ad_payment_cancelled'
  get 'business/ad_payment_accepted', to: 'businesses#ad_payment_accepted'
  get 'business/new_book_advert', to: 'businesses#new_book_advert'
  post 'business/create_book_advert', to: 'businesses#create_book_advert'
  get 'business/directory', to: 'businesses#directory'
  post 'business/process_review', to: 'businesses#process_review'
  get 'business/search', to: 'businesses#search'
  get 'business/my_events', to: 'businesses#my_events'
  resources :businesses

  # Manager Area
  get 'manager', to: 'manager#index', as: 'manager/index'
  get "manager/dashboard", to: 'manager#dashboard', as: 'manager/dashboard'
  get 'manager/booklets', to: 'manager#booklets', as: 'manager/booklets'
  get 'manager/businesses', to: 'manager#businesses', as: 'manager/businesses'
  get 'manager/web_vouchers', to: 'manager#web_vouchers', as: 'manager/web_vouchers'
  get 'manager/settings', to: 'manager#settings', as: 'manager/settings'
  get 'manager/towns', to: 'manager#towns', as: 'manager/towns'
  get 'manager/business_categories', to: 'manager#business_categories', as: 'manager/business_categories'
  get 'manager/advert_sizes', to: 'manager#advert_sizes', as: 'manager/advert_sizes'
  get 'manager/add_credits', to: 'manager#add_credits', as: 'manager/add_credits'
  post 'manager/update_credits', to: 'manager#update_credits', as: 'manager/update_credits'
  get 'manager/new_business_account', to: 'manager#new_business_account', as: 'manager/new_business_account'
  post 'manager/create_business_account', to: 'manager#create_business_account', as: 'manager/create_business_account'
  get 'manager/new_business_profile', to: 'manager#new_business_profile', as: 'manager/new_business_profile'
  post 'manager/create_business_profile', to: 'manager#create_business_profile', as: 'manager/create_business_profile'
  get 'manager/edit_business_profile', to: 'manager#edit_business_profile', as: 'manager/edit_business_profile'
  post 'manager/update_business_profile', to: 'manager#update_business_profile', as: 'manager/update_business_profile'
  get 'manager/edit_web_voucher', to: 'manager#edit_web_voucher', as: 'manager/edit_web_voucher'
  put 'manager/update_web_voucher', to: 'manager#update_web_voucher', as: 'manager/update_web_voucher'
  get 'manager/expire_web_voucher', to: 'manager#expire_web_voucher', as: 'manager/expire_web_voucher'
  get 'manager/marketing_email', to: 'manager#marketing_email', as: 'manager/marketing_email'
  post 'manager/send_marketing_email', to: 'manager#send_marketing_email', as: 'manager/send_marketing_email'
  get 'manager/new_web_voucher', to: 'manager#new_web_voucher'
  post 'manager/create_web_voucher', to: 'manager#create_web_voucher'
  get 'manager/set_advert_paid', to: 'manager#set_advert_paid'
  get 'manager/articles', to: 'manager#articles'
  get 'manager/business_reviews', to: 'manager#business_reviews'
  get 'manager/edit_review', to: 'manager#edit_review'
  put 'manager/update_review', to: 'manager#update_review', as: 'manager/update_review'
  
  get 'contacts/create_a_business_listing', to: 'contacts#create_a_business_listing'
  get 'contacts/totally_delete_contact', to: 'contacts#totally_delete_contact'
  post 'contacts/add_contact_note', to: 'contacts#add_contact_note'
  resources :contacts
  resources :commissions
  resources :events
  resources :appointments
  resources :testimonials
  
  # Manager Reports
  get 'manager/reports', to: 'manager#reports'
  get 'manager/commission_report', to: 'manager#commission_report'
  get 'manager/commission_by_booklet', to: 'manager#commission_by_booklet'
  get 'manager/commission_by_booklet_print', to: 'manager#commission_by_booklet_print'
  
  get 'manager/create_contacts_from_existing_businesses', to: 'manager#create_contacts_from_existing_businesses'
  
  resources :towns
  resources :business_categories
  resources :advert_sizes
  
  resources :booklets
  
  resources :paypal_payments

  get 'print_voucher', to: 'web_vouchers#print', as: 'print_voucher'
  get 'web_vouchers/by_category'
  get 'web_vouchers/by_town'
  get 'web_vouchers/expire_voucher'
  resources :web_vouchers
  
  

  get 'advert/invoice', to: 'adverts#invoice'
  get 'print_invoice', to: 'adverts#print', as: 'print_invoice'
  get 'advert/pay_advert', to: 'adverts#pay_advert'
  resources :adverts
  
  get 'advert_comments/accept_design', to: 'advert_comments#accept_design'
  resources :advert_comments
  
  match 'articles/category', to: 'articles#category'
  resources :articles
  resources :article_comments

  # Static Pages
  get 'advertising', to: 'pages#advertising'
  get 'contact_us', to: 'pages#contact'
  post 'send_contact_form', to: 'pages#send_contact_form'
  get 'advert_enquiry', to: 'pages#advert_enquiry'
  post 'send_advert_enquiry', to: 'pages#send_advert_enquiry'

  get 'restaurant_vouchers', to: 'pages#restaurant_vouchers'
  get 'health_and_beauty_vouchers', to: 'pages#health_and_beauty_vouchers'
  get 'bars_pubs_and_clubs_vouchers', to: 'pages#bars_vouchers'
  get 'fast_food_and_takeaway_vouchers', to: 'pages#takeaway_vouchers'
  get 'motoring_vouchers', to: 'pages#motoring_vouchers'
  get 'fashion_vouchers', to: 'pages#fashion_vouchers'

  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'terms', to: 'pages#terms'
  
  get 'newsletter/unsubscribe', to: 'newsletters#unsubscribe'
  resources :newsletters
  
  # Error pages (404 etc)
  match "404", to: "errors#not_found"
  

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'web_vouchers#index'
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
