# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_07_184522) do
  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "group_members", id: false, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id", null: false
    t.integer "group_id", null: false
    t.index ["group_id"], name: "index_group_members_on_group_id"
    t.index ["student_id"], name: "index_group_members_on_student_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "group_id"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_owner_id"
    t.index ["course_id"], name: "index_groups_on_course_id"
    t.index ["group_owner_id"], name: "index_groups_on_group_owner_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "email_old"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "students"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "students"
  add_foreign_key "groups", "courses"
  add_foreign_key "groups", "students", column: "group_owner_id"
end
