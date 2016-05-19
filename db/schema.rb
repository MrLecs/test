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

ActiveRecord::Schema.define(version: 20160519215544) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.text     "content"
    t.boolean  "correct",     default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "answers_histories", force: :cascade do |t|
    t.integer "answer_id"
    t.integer "history_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.integer  "answer_id"
    t.string   "action"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "question_id"
    t.integer  "test_suite_id"
  end

  add_index "histories", ["answer_id"], name: "index_histories_on_answer_id"
  add_index "histories", ["question_id"], name: "index_histories_on_question_id"
  add_index "histories", ["test_suite_id"], name: "index_histories_on_test_suite_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "testing_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["testing_id"], name: "index_questions_on_testing_id"

  create_table "students", force: :cascade do |t|
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.integer  "group_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true

  create_table "test_suites", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "testing_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "result"
  end

  add_index "test_suites", ["student_id"], name: "index_test_suites_on_student_id"
  add_index "test_suites", ["testing_id"], name: "index_test_suites_on_testing_id"

  create_table "testings", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "timeout"
    t.boolean  "random_questions", default: false
    t.boolean  "random_answers",   default: false
  end

end
