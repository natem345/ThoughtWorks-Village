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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110508224841) do

  create_table "availability_calendars", :force => true do |t|
    t.integer  "availability_quotient"
    t.integer  "mentor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "availability_days", :force => true do |t|
    t.date     "availability_day"
    t.string   "availability"
    t.integer  "availability_calendar_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentees", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentors", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentorships", :force => true do |t|
    t.integer  "mentor_id"
    t.integer  "mentee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "password_resets", :force => true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "question_text"
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.string   "reason"
    t.string   "estimated_length"
    t.integer  "mentor_id"
    t.integer  "mentee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", :force => true do |t|
    t.text     "response_text"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.string   "title"
    t.integer  "length_in_years"
    t.string   "comfort_level"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "current_position"
    t.integer  "total_years_experience"
    t.string   "email"
    t.string   "password"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

end
