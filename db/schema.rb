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

ActiveRecord::Schema.define(version: 20161221123537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cat_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cats", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cat_type_id"
    t.integer  "location_id"
    t.string   "name"
    t.integer  "age"
    t.string   "color"
    t.integer  "hyperactivity"
    t.text     "about"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "health",        default: 5
    t.integer  "gender"
    t.index ["cat_type_id"], name: "index_cats_on_cat_type_id", using: :btree
    t.index ["location_id"], name: "index_cats_on_location_id", using: :btree
    t.index ["user_id"], name: "index_cats_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "cats", "cat_types"
  add_foreign_key "cats", "locations"
  add_foreign_key "cats", "users"
end