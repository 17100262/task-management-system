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

ActiveRecord::Schema.define(version: 20180525120822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tier", default: 5
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "external_locations", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_external_locations_on_company_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "company_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id"
    t.index ["company_id"], name: "index_locations_on_company_id"
    t.index ["department_id"], name: "index_locations_on_department_id"
  end

  create_table "shift_users", force: :cascade do |t|
    t.bigint "shift_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
    t.index ["shift_id"], name: "index_shift_users_on_shift_id"
    t.index ["user_id"], name: "index_shift_users_on_user_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "start_time"
    t.integer "shift_status"
    t.text "skills_required"
    t.bigint "external_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.bigint "company_id"
    t.datetime "end_time"
    t.index ["company_id"], name: "index_shifts_on_company_id"
    t.index ["external_location_id"], name: "index_shifts_on_external_location_id"
  end

  create_table "skill_users", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_skill_users_on_skill_id"
    t.index ["user_id"], name: "index_skill_users_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.string "name"
    t.date "date_of_completion"
    t.integer "duration"
    t.date "training_expiry"
    t.integer "training_type"
    t.string "training_provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_trainings_on_company_id"
  end

  create_table "trainings_users", id: false, force: :cascade do |t|
    t.bigint "training_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "user_locations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_user_locations_on_location_id"
    t.index ["user_id"], name: "index_user_locations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "employee_number"
    t.string "landline_number"
    t.string "mobile_number"
    t.string "address"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.boolean "password_changed", default: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "external_locations", "companies"
  add_foreign_key "locations", "companies"
  add_foreign_key "locations", "departments"
  add_foreign_key "shift_users", "shifts"
  add_foreign_key "shift_users", "users"
  add_foreign_key "shifts", "companies"
  add_foreign_key "shifts", "external_locations"
  add_foreign_key "skill_users", "skills"
  add_foreign_key "skill_users", "users"
  add_foreign_key "trainings", "companies"
  add_foreign_key "user_locations", "locations"
  add_foreign_key "user_locations", "users"
  add_foreign_key "users", "companies"
end
