# frozen_string_literal: true

class CreatePhones < ActiveRecord::Migration[5.1]
  def change
    create_table :phones do |t|
      t.string :manufacturer, null: false
      t.string :model, null: false
      t.integer :manufacture_year
      t.timestamps
    end
    add_index :phones, %i[manufacturer model], unique: true
  end
end
