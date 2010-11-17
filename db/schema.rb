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

ActiveRecord::Schema.define(:version => 20101116062933) do

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",      :default => true
  end

  create_table "entity_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "price"
    t.string   "url"
    t.string   "shop_name"
    t.string   "shop_address"
    t.string   "shop_suburb"
    t.string   "shop_state"
    t.string   "shop_country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shop_hash"
    t.string   "shop_city"
    t.integer  "shop_id"
    t.boolean  "delta",          :default => true
    t.string   "image"
    t.string   "colour"
    t.string   "item_type"
    t.string   "original_price"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "suburb"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "feed"
    t.string   "ingestor"
  end

  create_table "sync_items", :force => true do |t|
    t.string   "item"
    t.string   "group"
    t.string   "class_name"
    t.string   "class_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "ug_items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "price"
    t.string   "url"
    t.string   "location"
    t.boolean  "import",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
