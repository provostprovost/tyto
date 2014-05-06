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

ActiveRecord::Schema.define(version: 20140506161437) do

  create_table "assignments", force: true do |t|
    t.integer "student_id"
    t.integer "teacher_id"
    t.integer "chapter_id"
    t.integer "classroom_id"
    t.boolean "complete"
    t.integer "assignment_size"
  end

  create_table "chapters", force: true do |t|
    t.string  "name"
    t.integer "parent_id"
  end

  create_table "classrooms", force: true do |t|
    t.integer "teacher_id"
    t.integer "course_id"
    t.string  "name"
  end

  create_table "classrooms_users", force: true do |t|
    t.integer "classroom_id"
    t.integer "student_id"
  end

  create_table "courses", force: true do |t|
    t.string "name"
  end

  create_table "questions", force: true do |t|
    t.integer "chapter_id"
    t.string  "question"
    t.string  "answer"
    t.integer "level"
  end

  create_table "responses", force: true do |t|
    t.integer "question_id"
    t.integer "student_id"
    t.integer "assignment_id"
    t.integer "chapter_id"
    t.boolean "correct"
    t.boolean "difficult"
    t.integer "proficiency"
  end

  create_table "sessions", force: true do |t|
    t.integer "student_id"
    t.integer "teacher_id"
  end

  create_table "students", force: true do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "phone_number"
  end

  create_table "teachers", force: true do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "phone_number"
  end

end
