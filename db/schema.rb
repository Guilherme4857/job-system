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

ActiveRecord::Schema.define(version: 2021_03_05_094625) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "applied_job_seekers", force: :cascade do |t|
    t.integer "job_seeker_id", null: false
    t.integer "job_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_applied_job_seekers_on_job_id"
    t.index ["job_seeker_id"], name: "index_applied_job_seekers_on_job_seeker_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.string "site"
    t.text "company_history"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_history"], name: "index_companies_on_company_history", unique: true
    t.index ["name"], name: "index_companies_on_name", unique: true
    t.index ["site"], name: "index_companies_on_site", unique: true
  end

  create_table "company_addresses", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "public_place"
    t.string "district"
    t.string "city"
    t.string "zip_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_addresses_on_company_id"
  end

  create_table "company_employees", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "employee_id", null: false
    t.string "hostname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_employees_on_company_id"
    t.index ["employee_id"], name: "index_company_employees_on_employee_id"
  end

  create_table "company_social_webs", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "address_web"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_web"], name: "index_company_social_webs_on_address_web", unique: true
    t.index ["company_id"], name: "index_company_social_webs_on_company_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "cpf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["cpf"], name: "index_employees_on_cpf", unique: true
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "job_disables", force: :cascade do |t|
    t.integer "job_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_job_disables_on_job_id"
  end

  create_table "job_levels", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "level_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_job_levels_on_job_id"
    t.index ["level_id"], name: "index_job_levels_on_level_id"
  end

  create_table "job_seekers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "social_name"
    t.string "cpf"
    t.string "phone"
    t.text "cv"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cpf"], name: "index_job_seekers_on_cpf", unique: true
    t.index ["cv"], name: "index_job_seekers_on_cv", unique: true
    t.index ["email"], name: "index_job_seekers_on_email", unique: true
    t.index ["phone"], name: "index_job_seekers_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_job_seekers_on_reset_password_token", unique: true
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "title"
    t.text "description"
    t.string "pay_scale"
    t.string "requirements"
    t.date "expiration_date"
    t.integer "job_openings"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_jobs_on_company_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "applied_job_seekers", "job_seekers"
  add_foreign_key "applied_job_seekers", "jobs"
  add_foreign_key "company_addresses", "companies"
  add_foreign_key "company_employees", "companies"
  add_foreign_key "company_employees", "employees"
  add_foreign_key "company_social_webs", "companies"
  add_foreign_key "job_disables", "jobs"
  add_foreign_key "job_levels", "jobs"
  add_foreign_key "job_levels", "levels"
  add_foreign_key "jobs", "companies"
end
