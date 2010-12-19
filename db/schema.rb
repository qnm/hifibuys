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

ActiveRecord::Schema.define(:version => 20101203091754) do

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",      :default => true
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "price"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",          :default => true
    t.string   "original_price"
    t.integer  "submitter_id"
    t.integer  "seller_id"
  end

  create_table "login_accounts", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.string   "remote_account_id"
    t.string   "name"
    t.string   "login"
    t.string   "picture_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "login_accounts", ["type"], :name => "index_login_accounts_on_type"
  add_index "login_accounts", ["user_id"], :name => "index_login_accounts_on_user_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "suburb"
    t.string   "city"
    t.string   "state"
    t.string   "country"
  end

end
