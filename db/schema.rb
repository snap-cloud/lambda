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

ActiveRecord::Schema.define(version: 20170702051010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "blazer_audits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "query_id"
    t.text     "statement"
    t.string   "data_source"
    t.datetime "created_at"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.integer  "query_id"
    t.string   "state"
    t.text     "emails"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.integer  "dashboard_id"
    t.integer  "query_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.text     "description"
    t.text     "statement"
    t.string   "data_source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.hstore   "configuration"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "courses", ["name"], name: "index_courses_on_name", unique: true, using: :btree

  create_table "dce_lti_nonces", force: :cascade do |t|
    t.string   "nonce"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dce_lti_nonces", ["nonce"], name: "index_dce_lti_nonces_on_nonce", unique: true, using: :btree

  create_table "dce_lti_users", force: :cascade do |t|
    t.string   "lti_user_id"
    t.string   "lis_person_contact_email_primary"
    t.string   "lis_person_name_family"
    t.string   "lis_person_name_full"
    t.string   "lis_person_name_given"
    t.string   "lis_person_sourcedid"
    t.string   "user_image"
    t.string   "roles",                            default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pghero_query_stats", force: :cascade do |t|
    t.text     "database"
    t.text     "query"
    t.float    "total_time"
    t.integer  "calls",       limit: 8
    t.datetime "captured_at"
  end

  add_index "pghero_query_stats", ["database", "captured_at"], name: "index_pghero_query_stats_on_database_and_captured_at", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.float    "points"
    t.text     "content"
    t.text     "test_file"
    t.text     "starter_file"
    t.jsonb    "metadata"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer  "question_id"
    t.float    "score"
    t.string   "code_submission"
    t.string   "test_results"
    t.json     "user_info"
    t.integer  "session_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "dce_lti_user_id"
  end

  add_index "submissions", ["dce_lti_user_id"], name: "index_submissions_on_dce_lti_user_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image_url"
    t.string   "url"
    t.string   "email"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "admin",                            default: false
    t.string   "lti_user_id"
    t.string   "lis_person_contact_email_primary"
    t.string   "lis_person_name_family"
    t.string   "lis_person_name_full"
    t.string   "lis_person_name_given"
    t.string   "lis_person_sourcedid"
    t.string   "user_image"
    t.string   "roles",                            default: [],                 array: true
  end

  add_index "users", ["lti_user_id"], name: "index_users_on_lti_user_id", unique: true, using: :btree

end
