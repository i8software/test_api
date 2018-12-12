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

ActiveRecord::Schema.define(version: 2018_12_12_111239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "commenter_id"
    t.uuid "geo_cache_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "replies_count", default: 0
    t.integer "likes_count", default: 0
    t.integer "unlikes_count", default: 0
    t.index ["commenter_id"], name: "index_comments_on_commenter_id"
    t.index ["geo_cache_id"], name: "index_comments_on_geo_cache_id"
  end

  create_table "geo_caches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "cacher_id"
    t.string "message"
    t.string "title"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comments_count", default: 0
    t.integer "likes_count", default: 0
    t.integer "unlikes_count", default: 0
    t.index ["cacher_id"], name: "index_geo_caches_on_cacher_id"
  end

  create_table "oauth_access_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "resource_owner_id"
    t.uuid "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "reactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "reactor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reacted_on_type"
    t.uuid "reacted_on_id"
    t.integer "reaction"
    t.index ["reacted_on_type", "reacted_on_id"], name: "index_reactions_on_reacted_on_type_and_reacted_on_id"
    t.index ["reactor_id"], name: "index_reactions_on_reactor_id"
  end

  create_table "replies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "comment_id"
    t.string "reply"
    t.uuid "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0
    t.integer "unlikes_count", default: 0
    t.index ["comment_id"], name: "index_replies_on_comment_id"
    t.index ["sender_id"], name: "index_replies_on_sender_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.integer "geo_caches_count", default: 0
    t.integer "comments_count", default: 0
    t.integer "replies_count", default: 0
    t.integer "likes_count", default: 0
    t.integer "unlikes_count", default: 0
    t.string "avatar_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "geo_caches", column: "geo_cache_id"
  add_foreign_key "comments", "users", column: "commenter_id"
  add_foreign_key "geo_caches", "users", column: "cacher_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "reactions", "users", column: "reactor_id"
  add_foreign_key "replies", "comments"
  add_foreign_key "replies", "users", column: "sender_id"
end
