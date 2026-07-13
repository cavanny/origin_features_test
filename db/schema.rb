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

ActiveRecord::Schema[7.2].define(version: 2026_07_13_173740) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asset_assignments", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.bigint "employe_id", null: false
    t.datetime "checked_out_at", null: false
    t.datetime "checked_in_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_id"], name: "index_asset_assignments_on_asset_id"
    t.index ["asset_id"], name: "index_asset_assignments_on_one_active_per_asset", unique: true, where: "(checked_in_at IS NULL)"
    t.index ["employe_id"], name: "index_asset_assignments_on_employe_id"
  end

  create_table "assets", force: :cascade do |t|
    t.string "name"
    t.string "serial"
    t.string "checkedOutTo"
    t.float "purchaseCost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "status_id"
    t.index ["category_id"], name: "index_assets_on_category_id"
    t.index ["status_id"], name: "index_assets_on_status_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "employes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "employeName"
    t.string "title"
    t.string "departement"
    t.string "office"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name", null: false
    t.string "color", default: "gray", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_statuses_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "asset_assignments", "assets"
  add_foreign_key "asset_assignments", "employes"
  add_foreign_key "assets", "categories"
  add_foreign_key "assets", "statuses"
end
