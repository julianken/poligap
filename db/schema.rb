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

ActiveRecord::Schema.define(version: 20161205234318) do

  create_table "representatives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "state_id"
    t.string   "full_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "cid"
    t.string   "state_abbreviated"
    t.string   "state_full"
    t.string   "chamber"
    t.string   "image_url"
    t.string   "gender"
    t.string   "website"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "twitter_id"
    t.string   "youtube_url"
    t.string   "facebook_id"
    t.string   "congress_office"
    t.string   "party"
    t.string   "birthdate"
    t.string   "webform"
    t.float    "cash_total",        limit: 24
    t.float    "cash_on_hand",      limit: 24
    t.float    "cash_spent",        limit: 24
    t.float    "cash_debt",         limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "contributors",      limit: 65535
  end

  create_table "states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "abbreviated_name"
    t.string "full_name"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
