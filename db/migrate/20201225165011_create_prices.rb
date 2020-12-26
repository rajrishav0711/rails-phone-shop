# frozen_string_literal: true

class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.references :variant, foreign_key: true
      t.decimal :amount
      t.timestamps
    end
  end
end
