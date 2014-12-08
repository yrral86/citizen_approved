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

ActiveRecord::Schema.define(version: 20141208000034) do

  create_table "bills", force: true do |t|
    t.string   "title",        limit: 255
    t.integer  "number",       limit: 4
    t.boolean  "senate",       limit: 1
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "govtrack_id",  limit: 4
    t.string   "govtrack_url", limit: 255
    t.string   "thomas_url",   limit: 255
    t.integer  "congress",     limit: 4
    t.text     "summary",      limit: 65535
    t.boolean  "current",      limit: 1,     default: false
  end

  add_index "bills", ["govtrack_id"], name: "index_bills_on_govtrack_id", unique: true, using: :btree

  create_table "congress_data", force: true do |t|
    t.integer  "congress",   limit: 4
    t.integer  "proposed",   limit: 4
    t.integer  "enacted",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "congresses", force: true do |t|
    t.integer  "number",     limit: 4
    t.integer  "session",    limit: 4
    t.date     "dstart"
    t.date     "dend"
    t.boolean  "current",    limit: 1, default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "districts", force: true do |t|
    t.boolean  "senate",     limit: 1
    t.string   "state_code", limit: 255
    t.integer  "number",     limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "type",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_district_id",      limit: 4
    t.integer  "senate_district_id",     limit: 4
    t.string   "voter_id",               limit: 255
    t.string   "name",                   limit: 255
    t.string   "address",                limit: 255
    t.string   "address2",               limit: 255
    t.string   "city",                   limit: 255
    t.string   "state_code",             limit: 255
    t.string   "zip",                    limit: 255
    t.boolean  "verified",               limit: 1,   default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["house_district_id"], name: "index_users_on_house_district_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["senate_district_id"], name: "index_users_on_senate_district_id", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "voter_id",   limit: 4
    t.integer  "bill_id",    limit: 4
    t.string   "choice",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
