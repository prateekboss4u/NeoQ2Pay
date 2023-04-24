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

ActiveRecord::Schema[7.0].define(version: 2023_04_20_094920) do
  create_table "bank_account_transactions", force: :cascade do |t|
    t.integer "bank_account_id", null: false
    t.decimal "amount"
    t.date "execution_date"
    t.string "operation"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recipient_bank_account_number"
    t.string "recipient_bank_account_type"
    t.string "recipient_bank_account_holders_name"
    t.string "recipient_bank_account_ifsc_code"
    t.string "recipient_bank_name"
    t.string "recipient_bank_branch"
    t.index ["bank_account_id"], name: "index_bank_account_transactions_on_bank_account_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "account_number", null: false
    t.string "bank_name", null: false
    t.string "ifsc_code", null: false
    t.decimal "opening_balance", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bank_account_transactions", "bank_accounts"
  add_foreign_key "bank_accounts", "users"
end
