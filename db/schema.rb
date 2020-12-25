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

ActiveRecord::Schema.define(version: 20201226041206) do

  create_table "phones", force: :cascade do |t|
    t.string "manufacturer", null: false
    t.string "model", null: false
    t.integer "manufacture_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacturer", "model"], name: "index_phones_on_manufacturer_and_model", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.integer "phone_id"
    t.string "storage"
    t.string "color"
    t.integer "count_on_hand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_id", "storage", "color"], name: "index_variants_on_phone_id_and_storage_and_color", unique: true
    t.index ["phone_id"], name: "index_variants_on_phone_id"
  end

end
