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

ActiveRecord::Schema.define(version: 20140626213408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gifts", force: true do |t|
    t.string   "gift_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gift_comp_id"
    t.string   "recipient_name"
    t.string   "relationship_to_gifter"
    t.text     "description"
    t.string   "cause"
    t.string   "other_cause"
    t.text     "inspiration"
    t.text     "feel"
    t.text     "detailed_message"
    t.string   "status"
    t.string   "volunteer_photos"
    t.integer  "hours"
    t.string   "certificate_printed_by_user"
    t.string   "organization"
  end

  create_table "users", force: true do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "volunteer_photos", force: true do |t|
    t.integer  "gift_id"
    t.string   "volunteer_photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volunteers", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "organization"
    t.string   "hours"
    t.string   "location"
    t.string   "email"
    t.string   "contact_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
