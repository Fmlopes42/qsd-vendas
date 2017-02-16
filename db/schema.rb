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

ActiveRecord::Schema.define(version: 20170215182948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boletos", force: :cascade do |t|
    t.integer  "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_boletos_on_payment_id", using: :btree
  end

  create_table "credits", force: :cascade do |t|
    t.integer  "payment_id"
    t.string   "card_name"
    t.string   "card_number"
    t.string   "card_validity"
    t.string   "card_ccv"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["payment_id"], name: "index_credits_on_payment_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "product"
    t.string   "plan"
    t.string   "price"
    t.string   "period"
    t.string   "coupon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "status"
    t.string   "source_ip"
    t.integer  "seller_id"
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.string   "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "boletos", "payments"
  add_foreign_key "credits", "payments"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
end
