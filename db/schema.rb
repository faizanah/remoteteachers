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

ActiveRecord::Schema.define(version: 20190116203542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rooms", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "uid"
    t.string   "bbb_id"
    t.integer  "sessions",     default: 0
    t.datetime "last_session"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["bbb_id"], name: "index_rooms_on_bbb_id", using: :btree
    t.index ["last_session"], name: "index_rooms_on_last_session", using: :btree
    t.index ["name"], name: "index_rooms_on_name", using: :btree
    t.index ["sessions"], name: "index_rooms_on_sessions", using: :btree
    t.index ["uid"], name: "index_rooms_on_uid", using: :btree
    t.index ["user_id"], name: "index_rooms_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.integer  "room_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "social_uid"
    t.string   "image"
    t.integer  "role",                 default: 0
    t.integer  "invited_by_id"
    t.string   "invitation_token"
    t.string   "password_digest"
    t.boolean  "accepted_terms",       default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "email_verified",       default: false
    t.string   "language",             default: "default"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "status",               default: 0
    t.integer  "number_of_rooms",      default: 0
    t.integer  "number_of_recordings", default: 0
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["password_digest"], name: "index_users_on_password_digest", unique: true, using: :btree
    t.index ["room_id"], name: "index_users_on_room_id", using: :btree
  end

end
