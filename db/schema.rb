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

ActiveRecord::Schema[7.1].define(version: 2024_07_16_073638) do
  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.decimal "wallet_balance", precision: 10, scale: 2, default: "1000000.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "loans", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.decimal "interest_rate", precision: 5, scale: 2, default: "5.0"
    t.integer "status", default: 0
    t.integer "user_id", null: false
    t.integer "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_loans_on_admin_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.decimal "wallet_balance", precision: 10, scale: 2, default: "10000.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "loans", "admins"
  add_foreign_key "loans", "users"
end
