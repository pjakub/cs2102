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

ActiveRecord::Schema.define(version: 20150328140058) do

  create_table "articles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.string   "title",            default: ""
    t.text     "comment"
    t.integer  "upvotes",          default: 0
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"

  create_table "posts", force: :cascade do |t|
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["article_id"], name: "index_posts_on_article_id"

  create_table "replies", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "replies", ["article_id"], name: "index_replies_on_article_id"
  add_index "replies", ["post_id"], name: "index_replies_on_post_id"

  create_table "user_sessions.css", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions.css", ["session_id"], name: "index_user_sessions.css_on_session_id"
  add_index "user_sessions.css", ["updated_at"], name: "index_user_sessions.css_on_updated_at"

  create_table "users", force: :cascade do |t|
    t.string   "first_name",          default: "", null: false
    t.string   "last_name",           default: "", null: false
    t.string   "email",                            null: false
    t.string   "crypted_password",                 null: false
    t.string   "password_salt",                    null: false
    t.string   "persistence_token",                null: false
    t.string   "single_access_token",              null: false
    t.string   "perishable_token",                 null: false
    t.integer  "login_count",         default: 0,  null: false
    t.integer  "failed_login_count",  default: 0,  null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
