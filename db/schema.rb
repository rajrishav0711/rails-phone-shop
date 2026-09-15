# This file is auto-generated from the current state of the database.
# Instead of editing this file, use the migrations feature of Active Record.

ActiveRecord::Schema[8.1].define(version: 20_201_226_041_206) do
  create_table "phones", force: :cascade do |t|
    t.string "manufacturer", null: false
    t.string "model", null: false
    t.integer "manufacture_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacturer", "model"], name: "index_phones_on_manufacturer_and_model", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.integer "variant_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["variant_id"], name: "index_prices_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.integer "phone_id"
    t.string "storage"
    t.string "color"
    t.integer "count_on_hand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_id"], name: "index_variants_on_phone_id"
    t.index ["phone_id", "storage", "color"], name: "index_variants_on_phone_id_and_storage_and_color", unique: true
  end
end
