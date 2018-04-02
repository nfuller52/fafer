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

ActiveRecord::Schema.define(version: 20180331181029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_listings", force: :cascade do |t|
    t.string "title", null: false
    t.integer "platform", default: 0, null: false
    t.boolean "allow_remote", default: false, null: false
    t.string "location", null: false
    t.text "description", null: false
    t.string "slug", null: false
    t.string "company", null: false
    t.string "contact", null: false
    t.datetime "publish_at", default: "2018-04-02 18:12:41", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["allow_remote"], name: "index_job_listings_on_allow_remote"
    t.index ["company"], name: "index_job_listings_on_company"
    t.index ["platform"], name: "index_job_listings_on_platform"
    t.index ["slug"], name: "index_job_listings_on_slug"
  end

end