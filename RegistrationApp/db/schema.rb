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

ActiveRecord::Schema.define(version: 20150127222511) do

  create_table "application_types", force: true do |t|
    t.string   "name",       limit: 20, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: true do |t|
    t.integer  "user_id"
    t.integer  "application_type_id"
    t.string   "name",                limit: 100, null: false
    t.string   "api_key",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applications", ["api_key"], name: "index_applications_on_api_key", unique: true

  create_table "users", force: true do |t|
    t.string   "password_digest",             null: false
    t.string   "email",           limit: 254, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
