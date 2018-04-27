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

ActiveRecord::Schema.define(version: 2018_04_18_052503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price_in_cents", null: false
    t.string "feature_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_listings", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "allow_remote", default: false, null: false
    t.string "location", null: false
    t.text "description", null: false
    t.string "slug", null: false
    t.string "company", null: false
    t.string "contact_email", null: false
    t.string "contact_name", null: false
    t.date "publish_date"
    t.date "expiration_date"
    t.boolean "is_published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "platform_id"
    t.index ["allow_remote"], name: "index_job_listings_on_allow_remote"
    t.index ["expiration_date"], name: "index_job_listings_on_expiration_date"
    t.index ["platform_id"], name: "index_job_listings_on_platform_id"
    t.index ["slug"], name: "index_job_listings_on_slug"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "order_id"
    t.integer "price_in_cents", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "job_listing_id"
    t.integer "total_in_cents", default: 0
    t.string "customer_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_listing_id"], name: "index_orders_on_job_listing_id"
    t.index ["status"], name: "index_orders_on_status"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_id"
    t.index ["item_id"], name: "index_platforms_on_item_id"
    t.index ["slug"], name: "index_platforms_on_slug"
  end

  add_foreign_key "job_listings", "platforms"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "job_listings"
  add_foreign_key "platforms", "items"
end
