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

ActiveRecord::Schema.define(version: 2021_02_23_171554) do

  create_table "filters", force: :cascade do |t|
    t.integer "visualization_id", null: false
    t.text "variable_name"
    t.text "filter_type"
    t.text "value1"
    t.text "value2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["visualization_id"], name: "index_filters_on_visualization_id"
  end

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
    t.string "FDS_cat"
    t.string "gs_select"
    t.string "gs_level"
    t.string "gs_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "variables", force: :cascade do |t|
    t.integer "visualization_id"
    t.string "name"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["visualization_id"], name: "index_variables_on_visualization_id"
  end

  create_table "visualizations", force: :cascade do |t|
    t.string "chart_type"
    t.string "x_axis_title"
    t.string "y_axis_title"
    t.string "chart_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "filters", "visualizations"
end
