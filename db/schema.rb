# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_17_221141) do

  create_table "answered_questions", force: :cascade do |t|
    t.boolean "answered_correctly"
    t.integer "user_id"
    t.integer "question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "category"
    t.string "difficulty"
    t.string "question"
    t.string "correct_answer"
    t.string "incorrect_answers"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.integer "total_points"
    t.integer "level"
  end

end
