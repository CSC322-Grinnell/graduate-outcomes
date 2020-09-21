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

ActiveRecord::Schema.define(version: 2020_09_21_230918) do

  create_table "students", force: :cascade do |t|
    t.string "class_year"
    t.string "student_id"
    t.string "major1"
    t.string "major2"
    t.string "gender"
    t.string "fed_group"
    t.string "intern"
    t.string "research"
    t.string "service"
    t.string "career_related"
    t.string "job_field"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
