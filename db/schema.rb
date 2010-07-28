# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100728102456) do

  create_table "answers", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "photo_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.string   "server_path"
    t.text     "exif"
    t.integer  "team_id"
    t.integer  "photo_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "rating_average",    :precision => 6, :scale => 2, :default => 0.0
  end

  create_table "question_answer_by_users", :force => true do |t|
    t.integer  "question_id", :null => false
    t.integer  "answer_id",   :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "hint"
    t.boolean  "is_commentable"
    t.boolean  "is_rateable"
    t.boolean  "is_voteable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
  end

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "response_versions", :force => true do |t|
    t.integer  "response_id"
    t.integer  "version"
    t.integer  "user_id"
    t.integer  "rating"
    t.text     "answer_text"
    t.datetime "updated_at"
  end

  create_table "responses", :force => true do |t|
    t.integer  "survey_sheet_id"
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "rating"
    t.text     "answer_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",         :default => 1
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "sections", :force => true do |t|
    t.integer  "number"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_id"
  end

  create_table "sheet_answer_relations", :force => true do |t|
    t.integer  "survey_sheet_id"
    t.integer  "answer_id"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sheet_histories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_sheet_id"
    t.datetime "when_submit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version_num"
  end

  create_table "sheet_question_relations", :force => true do |t|
    t.integer  "survey_sheet_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "smerf_forms", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "code",       :null => false
    t.integer  "active",     :null => false
    t.text     "cache"
    t.datetime "cache_date"
  end

  add_index "smerf_forms", ["code"], :name => "index_smerf_forms_on_code", :unique => true

  create_table "smerf_forms_users", :force => true do |t|
    t.integer "user_id",       :null => false
    t.integer "smerf_form_id", :null => false
    t.text    "responses",     :null => false
  end

  create_table "smerf_responses", :force => true do |t|
    t.integer "smerf_forms_user_id", :null => false
    t.string  "question_code",       :null => false
    t.text    "response",            :null => false
  end

  create_table "survey_question_assignments", :force => true do |t|
    t.integer  "survey_id",   :null => false
    t.integer  "question_id", :null => false
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_sheets", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "modification_count"
    t.integer  "user_id"
    t.integer  "survey_id"
  end

  create_table "surveys", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "category"
    t.string   "target_audience"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "guideline"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_places", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "team_name"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "fk_voteables"
  add_index "votes", ["voter_id", "voter_type"], :name => "fk_voters"

end
