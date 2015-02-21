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

ActiveRecord::Schema.define(version: 20150210223029) do

  create_table "application_types", force: true do |t|
    t.string   "name",       limit: 20, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: true do |t|
    t.integer  "developer_id"
    t.integer  "application_type_id"
    t.string   "name",                limit: 100, null: false
    t.string   "api_key",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applications", ["api_key"], name: "index_applications_on_api_key", unique: true

  create_table "creators", force: true do |t|
    t.string   "email",           limit: 254, null: false
    t.string   "password_digest",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "creators", ["email"], name: "index_creators_on_email", unique: true

  create_table "developers", force: true do |t|
    t.string   "name",            limit: 50,                  null: false
    t.string   "email",           limit: 254,                 null: false
    t.string   "password_digest",                             null: false
    t.boolean  "admin",                       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "developers", ["email"], name: "index_developers_on_email", unique: true
  add_index "developers", ["name"], name: "index_developers_on_name", unique: true

  create_table "stories", force: true do |t|
    t.integer  "creator_id"
    t.string   "name",        limit: 50, null: false
    t.text     "description",            null: false
    t.float    "latitude",               null: false
    t.float    "longitude",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories_tags", id: false, force: true do |t|
    t.integer "story_id"
    t.integer "tag_id"
  end

  add_index "stories_tags", ["story_id", "tag_id"], name: "index_stories_tags_on_story_id_and_tag_id"

  create_table "tags", force: true do |t|
    t.string   "name",       limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
