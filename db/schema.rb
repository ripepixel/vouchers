# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130611111912) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "fullname"
    t.string   "auth_level"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "advert_comments", :force => true do |t|
    t.integer  "advert_id"
    t.integer  "business_account_id"
    t.integer  "admin_user_id"
    t.string   "image"
    t.text     "comment"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "accepted"
  end

  create_table "advert_payments", :force => true do |t|
    t.integer  "advert_id"
    t.text     "params"
    t.string   "status"
    t.string   "txn_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "advert_sizes", :force => true do |t|
    t.string   "name"
    t.decimal  "cost"
    t.integer  "page_unit"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "adverts", :force => true do |t|
    t.integer  "booklet_id"
    t.integer  "business_id"
    t.integer  "advert_size_id"
    t.decimal  "advert_cost"
    t.boolean  "paid"
    t.date     "valid_from"
    t.date     "valid_to"
    t.boolean  "featured"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "image"
    t.string   "resource_id"
    t.integer  "admin_user_id"
  end

  create_table "appointments", :force => true do |t|
    t.integer  "admin_user_id"
    t.string   "business_name"
    t.integer  "town_id"
    t.string   "telephone"
    t.string   "contact_name"
    t.text     "comments"
    t.datetime "appointment_time"
    t.integer  "advert_size_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "article_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "article_comments", :force => true do |t|
    t.integer  "article_id"
    t.string   "email"
    t.text     "comment"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "article_category_id"
    t.string   "author_name"
    t.boolean  "published"
    t.string   "image"
    t.string   "tags"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "url"
  end

  create_table "booklets", :force => true do |t|
    t.string   "name"
    t.integer  "town_id"
    t.string   "month"
    t.string   "year"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "expired"
    t.date     "cut_off_date"
    t.date     "start_date"
  end

  create_table "business_accounts", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "business_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "icon"
  end

  create_table "business_reviews", :force => true do |t|
    t.integer  "business_id"
    t.string   "email"
    t.string   "name"
    t.integer  "rating"
    t.text     "comments"
    t.boolean  "published"
    t.boolean  "active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "businesses", :force => true do |t|
    t.integer  "business_account_id"
    t.string   "business_name"
    t.integer  "business_category_id"
    t.string   "street"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.string   "telephone"
    t.string   "website"
    t.string   "email"
    t.string   "logo"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "image"
    t.text     "about_us"
    t.string   "url"
    t.boolean  "hidden"
  end

  create_table "commissions", :force => true do |t|
    t.integer  "admin_user_id"
    t.integer  "advert_size_id"
    t.decimal  "rate"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "active"
  end

  create_table "events", :force => true do |t|
    t.integer  "business_id"
    t.string   "title"
    t.text     "details"
    t.string   "image"
    t.date     "date_from"
    t.date     "date_to"
    t.text     "prices"
    t.string   "street"
    t.string   "town"
    t.string   "postcode"
    t.string   "telephone"
    t.string   "website"
    t.string   "email"
    t.boolean  "active"
    t.boolean  "featured"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "url"
  end

  create_table "marketing_emails", :force => true do |t|
    t.string   "email"
    t.boolean  "subscribed"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "newsletters", :force => true do |t|
    t.string   "email"
    t.boolean  "subscribed"
    t.date     "unsubscribe_date"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "paypal_payments", :force => true do |t|
    t.integer  "web_voucher_id"
    t.integer  "advert_id"
    t.text     "params"
    t.string   "status"
    t.string   "txn_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "towns", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "web_voucher_analytics", :force => true do |t|
    t.integer  "web_voucher_id"
    t.boolean  "viewed"
    t.boolean  "printed"
    t.boolean  "thumbs_up"
    t.boolean  "thumbs_down"
    t.string   "remote_ip"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "web_voucher_credits", :force => true do |t|
    t.integer  "business_account_id"
    t.integer  "credits"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "reason"
    t.integer  "admin_user_id"
  end

  create_table "web_voucher_payments", :force => true do |t|
    t.integer  "web_voucher_id"
    t.text     "params"
    t.string   "status"
    t.string   "txn_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "web_vouchers", :force => true do |t|
    t.integer  "business_account_id"
    t.string   "title"
    t.text     "details"
    t.text     "terms"
    t.date     "start_date"
    t.date     "expiry_date"
    t.integer  "advert_id"
    t.boolean  "featured"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "business_category_id"
    t.string   "status"
    t.integer  "town_id"
    t.string   "url"
    t.string   "resource_id"
    t.string   "town"
    t.string   "weblink"
  end

end
