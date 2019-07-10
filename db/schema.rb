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

ActiveRecord::Schema.define(version: 20190710152328) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.string   "widget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatfuel_bot_subscribers", force: :cascade do |t|
    t.string   "fb_messenger_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "chatfuel_bot_subscriptions", force: :cascade do |t|
    t.integer  "chatfuel_bot_subscriber_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "subscribed_bib_id"
    t.index ["chatfuel_bot_subscriber_id"], name: "index_chatfuel_bot_subscriptions_on_chatfuel_bot_subscriber_id", using: :btree
    t.index ["subscribed_bib_id"], name: "index_chatfuel_bot_subscriptions_on_subscribed_bib_id", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "results_widget"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "editions", force: :cascade do |t|
    t.date     "date"
    t.string   "description"
    t.integer  "event_id"
    t.string   "email_sender"
    t.string   "email_name"
    t.string   "hashtag"
    t.string   "results_url"
    t.string   "sms_message"
    t.string   "template"
    t.datetime "widget_generated_at"
    t.datetime "photos_widget_generated_at"
    t.string   "external_link"
    t.string   "external_link_button"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "raw_results_file_name"
    t.string   "raw_results_content_type"
    t.integer  "raw_results_file_size"
    t.datetime "raw_results_updated_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.boolean  "sendable_at_home",                default: false
    t.integer  "sendable_at_home_price_cents"
    t.boolean  "download_chargeable",             default: false
    t.integer  "download_chargeable_price_cents"
    t.string   "facebook_twitter_message"
    t.string   "facebook_page_id"
    t.boolean  "live_mode_on",                    default: false
    t.boolean  "facebook_live_on",                default: false
    t.boolean  "twitter_live_on",                 default: false
    t.integer  "user_id"
    t.string   "elite_runner_bibs"
    t.string   "livetrail_url"
    t.string   "finish_message"
    t.string   "chatfuel_bot_id"
    t.string   "chatfuel_bot_token"
    t.string   "registration_link"
    t.string   "dropbox_token"
    t.string   "dropbox_path"
    t.index ["chatfuel_bot_id"], name: "index_editions_on_chatfuel_bot_id", using: :btree
    t.index ["user_id"], name: "index_editions_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "place"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instagram"
    t.string   "contact"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "client_1"
    t.integer  "client_2"
    t.integer  "client_3"
    t.string   "department"
    t.integer  "challenge_id"
    t.boolean  "global_challenge"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "photos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "race_id"
    t.string   "suggested_bibs"
    t.string   "bib"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "edition_id"
    t.string   "direct_image_url"
    t.boolean  "processed",          default: false
    t.index ["race_id"], name: "index_photos_on_race_id", using: :btree
  end

  create_table "races", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "email_sender"
    t.string   "email_name"
    t.date     "date"
    t.string   "hashtag"
    t.string   "results_url"
    t.string   "sms_message"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "raw_results_file_name"
    t.string   "raw_results_content_type"
    t.integer  "raw_results_file_size"
    t.datetime "raw_results_updated_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "template"
    t.datetime "widget_generated_at"
    t.datetime "photos_widget_generated_at"
    t.string   "external_link"
    t.string   "external_link_button"
    t.integer  "edition_id"
    t.integer  "coef"
    t.string   "category"
    t.string   "department"
    t.string   "race_type"
    t.string   "elite_runners"
    t.datetime "start_at"
    t.float    "distance"
    t.index ["edition_id"], name: "index_races_on_edition_id", using: :btree
  end

  create_table "results", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "race_id"
    t.string   "phone"
    t.string   "mail"
    t.integer  "rank"
    t.string   "name"
    t.string   "country"
    t.string   "bib"
    t.integer  "categ_rank"
    t.string   "categ"
    t.integer  "sex_rank"
    t.string   "sex"
    t.string   "time"
    t.string   "speed"
    t.string   "message"
    t.string   "race_detail"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.datetime "uploaded_at"
    t.datetime "diploma_generated_at"
    t.datetime "email_sent_at"
    t.datetime "sms_sent_at"
    t.string   "diploma_url"
    t.integer  "runner_id"
    t.integer  "points"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "dob"
    t.boolean  "processed",            default: false
    t.string   "diploma_file_name"
    t.string   "diploma_content_type"
    t.integer  "diploma_file_size"
    t.datetime "diploma_updated_at"
    t.datetime "purchased_at"
    t.string   "stripe_charge_id"
    t.integer  "edition_id"
    t.string   "race_name"
    t.string   "race_code"
    t.boolean  "finish"
    t.index ["edition_id"], name: "index_results_on_edition_id", using: :btree
    t.index ["race_id"], name: "index_results_on_race_id", using: :btree
  end

  create_table "runners", force: :cascade do |t|
    t.string   "id_key"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "dob"
    t.string   "department"
    t.string   "sex"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "category"
    t.boolean  "real",               default: true
    t.boolean  "sportagora_visible", default: true
    t.index ["id_key"], name: "index_runners_on_id_key", unique: true, using: :btree
    t.index ["last_name", "first_name"], name: "index_runners_on_last_name_and_first_name", using: :btree
    t.index ["real"], name: "index_runners_on_real", using: :btree
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "runner_id"
    t.integer  "points"
    t.string   "race_type"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["runner_id"], name: "index_scores_on_runner_id", using: :btree
  end

  create_table "stages", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "time"
    t.integer  "rank"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "photo"
    t.string   "bib"
    t.string   "category"
    t.string   "idpt_num"
    t.string   "idpt_name"
    t.boolean  "posted_on_facebook", default: false
    t.boolean  "posted_on_twitter",  default: false
    t.uuid     "race_id"
    t.integer  "edition_id"
    t.string   "sex"
    t.string   "cat_rank"
    t.string   "km"
    t.boolean  "finish"
    t.string   "race_name"
    t.string   "race_code"
    t.index ["edition_id"], name: "index_stages_on_edition_id", using: :btree
    t.index ["race_id"], name: "index_stages_on_race_id", using: :btree
  end

  create_table "subscribed_bibs", force: :cascade do |t|
    t.integer  "edition_id"
    t.string   "bib"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sex"
    t.string   "message_position_block_id"
    t.string   "race_name"
    t.index ["bib"], name: "index_subscribed_bibs_on_bib", using: :btree
    t.index ["edition_id"], name: "index_subscribed_bibs_on_edition_id", using: :btree
  end

  create_table "user_providers", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "facebook_token"
    t.string   "name"
    t.index ["user_id"], name: "index_user_providers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "twitter_nickname"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "chatfuel_bot_subscriptions", "chatfuel_bot_subscribers"
  add_foreign_key "chatfuel_bot_subscriptions", "subscribed_bibs"
  add_foreign_key "editions", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "photos", "races"
  add_foreign_key "results", "editions"
  add_foreign_key "results", "races"
  add_foreign_key "stages", "editions"
  add_foreign_key "stages", "races"
  add_foreign_key "subscribed_bibs", "editions"
  add_foreign_key "user_providers", "users"
end
