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

ActiveRecord::Schema.define(version: 20160925205651) do

  create_table "purchase_orders", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_purchase_orders_on_name"
    t.index ["store_id"], name: "index_purchase_orders_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["name"], name: "index_stores_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "password_hash", null: false
    t.string   "password_salt", null: false
    t.integer  "role",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["name"], name: "index_users_on_name"
  end

end
