# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[8.1]
  def change
    create_table :variants do |t|
      t.references :phone, foreign_key: true
      t.string :storage
      t.string :color
      t.integer :count_on_hand
      t.timestamps
    end
    add_index :variants, %i[phone_id storage color], unique: true
  end
end
