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

ActiveRecord::Schema.define(version: 20141012231457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "assets", force: true do |t|
    t.integer  "parent_obj_id"
    t.string   "parent_obj_type"
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.text     "content"
    t.string   "type"
    t.string   "sub_type"
    t.string   "use"
    t.string   "asset_type",        default: "image"
    t.string   "origin_name"
    t.string   "origin_identifier"
    t.string   "origin_url"
    t.string   "upload"
    t.integer  "height"
    t.integer  "width"
    t.integer  "duration"
    t.integer  "status",            default: 0
    t.integer  "availability",      default: 0
    t.hstore   "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["parent_obj_id", "parent_obj_type", "asset_type", "use"], name: "swell_media_asset_use_index", using: :btree
  add_index "assets", ["parent_obj_type", "parent_obj_id"], name: "index_assets_on_parent_obj_type_and_parent_obj_id", using: :btree

  create_table "categories", force: true do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "name"
    t.string   "display"
    t.string   "type"
    t.integer  "lft"
    t.integer  "rgt"
    t.text     "description"
    t.integer  "status",       default: 0
    t.integer  "availability", default: 0
    t.integer  "seq"
    t.string   "slug"
    t.hstore   "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "categories", ["lft"], name: "index_categories_on_lft", using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["rgt"], name: "index_categories_on_rgt", using: :btree
  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  add_index "categories", ["type"], name: "index_categories_on_type", using: :btree
  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.string   "ip"
    t.string   "contact_type"
    t.string   "http_referrer"
    t.string   "status",        default: "active"
    t.hstore   "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["email"], name: "index_contacts_on_email", using: :btree

  create_table "media", force: true do |t|
    t.integer  "user_id"
    t.integer  "managed_by_id"
    t.string   "public_id"
    t.integer  "category_id"
    t.integer  "parent_obj_id"
    t.string   "parent_obj_type"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "type"
    t.string   "sub_type"
    t.string   "title"
    t.string   "subtitle"
    t.string   "avatar"
    t.string   "avatar_caption"
    t.text     "description"
    t.text     "content"
    t.string   "slug"
    t.boolean  "is_commentable",    default: true
    t.boolean  "is_sticky",         default: false
    t.boolean  "show_title",        default: true
    t.datetime "modified_at"
    t.text     "keywords",          default: [],    array: true
    t.string   "duration"
    t.integer  "price"
    t.integer  "status",            default: 0
    t.integer  "availability",      default: 0
    t.datetime "publish_at"
    t.hstore   "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_word_count"
    t.integer  "cached_char_count"
    t.tsvector "search_vector"
  end

  add_index "media", ["category_id"], name: "index_media_on_category_id", using: :btree
  add_index "media", ["managed_by_id"], name: "index_media_on_managed_by_id", using: :btree
  add_index "media", ["public_id"], name: "index_media_on_public_id", using: :btree
  add_index "media", ["search_vector"], name: "media_search_idx", using: :gin
  add_index "media", ["slug", "type"], name: "index_media_on_slug_and_type", using: :btree
  add_index "media", ["slug"], name: "index_media_on_slug", unique: true, using: :btree
  add_index "media", ["status", "availability"], name: "index_media_on_status_and_availability", using: :btree
  add_index "media", ["user_id"], name: "index_media_on_user_id", using: :btree

  create_table "media_thumbnails", force: true do |t|
    t.integer  "media_id"
    t.string   "name"
    t.string   "url"
    t.integer  "height"
    t.integer  "width"
    t.string   "caption"
    t.integer  "status",       default: 0
    t.integer  "availability", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media_thumbnails", ["media_id"], name: "index_media_thumbnails_on_media_id", using: :btree

  create_table "oauth_credentials", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "refresh_token"
    t.string   "secret"
    t.datetime "expires_at"
    t.integer  "status",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_credentials", ["provider"], name: "index_oauth_credentials_on_provider", using: :btree
  add_index "oauth_credentials", ["secret"], name: "index_oauth_credentials_on_secret", using: :btree
  add_index "oauth_credentials", ["token"], name: "index_oauth_credentials_on_token", using: :btree
  add_index "oauth_credentials", ["uid"], name: "index_oauth_credentials_on_uid", using: :btree
  add_index "oauth_credentials", ["user_id"], name: "index_oauth_credentials_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tasks", force: true do |t|
    t.integer  "assigned_to_id"
    t.integer  "requested_by_id"
    t.integer  "category_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.text     "content"
    t.integer  "status",          default: 0
    t.integer  "availability",    default: 0
    t.integer  "priority",        default: 1
    t.integer  "remind_time",     default: 0
    t.integer  "cached_duration", default: 0
    t.string   "slug"
    t.datetime "due_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timers", force: true do |t|
    t.integer  "parent_obj_id"
    t.string   "parent_obj_type"
    t.integer  "user_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer  "cached_duration"
    t.text     "notes"
    t.integer  "status",          default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timers", ["parent_obj_id", "parent_obj_type"], name: "index_timers_on_parent_obj_id_and_parent_obj_type", using: :btree
  add_index "timers", ["user_id"], name: "index_timers_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                            default: "",                           null: false
    t.string   "encrypted_password",               default: "",                           null: false
    t.string   "slug"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.datetime "dob"
    t.string   "gender"
    t.string   "location"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.integer  "status",                           default: 0
    t.integer  "level",                            default: 1
    t.integer  "max_investment",                   default: 10
    t.integer  "investment_cap",                   default: 100
    t.integer  "investment_used",                  default: 0
    t.string   "website_url"
    t.text     "bio"
    t.text     "sig"
    t.string   "ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "timezone",                         default: "Pacific Time (US & Canada)"
    t.text     "books",                            default: [],                                        array: true
    t.text     "games",                            default: [],                                        array: true
    t.text     "movies",                           default: [],                                        array: true
    t.text     "music",                            default: [],                                        array: true
    t.text     "television",                       default: [],                                        array: true
    t.integer  "points_earned",          limit: 8, default: 0
    t.integer  "points_balance",         limit: 8, default: 0
    t.integer  "cached_subscribe_count",           default: 0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "password_hint"
    t.string   "password_hint_response"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                  default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.hstore   "properties"
    t.hstore   "settings"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                             default: 1
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
