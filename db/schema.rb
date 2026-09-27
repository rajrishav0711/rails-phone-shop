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

ActiveRecord::Schema[8.1].define(version: 2026_09_20_113000) do
  create_table "inventories", force: :cascade do |t|
    t.integer "count_on_hand", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "variant_id", null: false
    t.index ["variant_id"], name: "index_inventories_on_variant_id", unique: true
  end

  create_table "phones", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "manufacture_year"
    t.string "manufacturer", null: false
    t.string "model", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacturer", "model"], name: "index_phones_on_manufacturer_and_model", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "variant_id"
    t.index ["variant_id"], name: "index_prices_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.integer "phone_id"
    t.string "storage"
    t.datetime "updated_at", null: false
    t.index ["phone_id", "storage", "color"], name: "index_variants_on_phone_id_and_storage_and_color", unique: true
    t.index ["phone_id"], name: "index_variants_on_phone_id"
  end

  add_foreign_key "inventories", "variants"
end
