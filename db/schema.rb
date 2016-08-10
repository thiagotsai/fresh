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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160810103431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_cuisines", force: :cascade do |t|
    t.integer  "business_place_id"
    t.integer  "cuisine_id"
    t.boolean  "main"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "business_cuisines", ["business_place_id"], name: "index_business_cuisines_on_business_place_id", using: :btree
  add_index "business_cuisines", ["cuisine_id"], name: "index_business_cuisines_on_cuisine_id", using: :btree

  create_table "business_place_users", force: :cascade do |t|
    t.integer  "business_place_id"
    t.integer  "user_id"
    t.boolean  "main"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "business_place_users", ["business_place_id"], name: "index_business_place_users_on_business_place_id", using: :btree
  add_index "business_place_users", ["user_id"], name: "index_business_place_users_on_user_id", using: :btree

  create_table "business_places", force: :cascade do |t|
    t.string   "address"
    t.string   "zip_code"
    t.string   "status"
    t.string   "name"
    t.string   "opening_time"
    t.string   "cover_photo"
    t.string   "average_cost"
    t.string   "phone_number"
    t.float    "lat"
    t.float    "lng"
    t.string   "from_status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "city"
    t.string   "country"
    t.string   "description"
  end

  create_table "cuisines", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_infos", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "ingredient_id"
    t.string   "preparation"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "item_infos", ["ingredient_id"], name: "index_item_infos_on_ingredient_id", using: :btree
  add_index "item_infos", ["item_id"], name: "index_item_infos_on_item_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "name"
    t.datetime "ready_at"
    t.decimal  "available_qty"
    t.integer  "user_id"
    t.string   "photo"
    t.string   "description"
    t.decimal  "price"
    t.string   "currency"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "items", ["menu_id"], name: "index_items_on_menu_id", using: :btree
  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.integer  "business_place_id"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "menus", ["business_place_id"], name: "index_menus_on_business_place_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.float    "lat"
    t.float    "lng"
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "business_cuisines", "business_places"
  add_foreign_key "business_cuisines", "cuisines"
  add_foreign_key "business_place_users", "business_places"
  add_foreign_key "business_place_users", "users"
  add_foreign_key "item_infos", "ingredients"
  add_foreign_key "item_infos", "items"
  add_foreign_key "items", "menus"
  add_foreign_key "items", "users"
  add_foreign_key "menus", "business_places"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
