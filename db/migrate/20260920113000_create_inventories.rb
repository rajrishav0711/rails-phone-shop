# frozen_string_literal: true

class CreateInventories < ActiveRecord::Migration[8.1]
  def up
    create_table :inventories do |t|
      t.references :variant, null: false, foreign_key: true, index: { unique: true }
      t.integer :count_on_hand, null: false
      t.timestamps
    end

    execute <<~SQL.squish
      INSERT INTO inventories (variant_id, count_on_hand, created_at, updated_at)
      SELECT id, COALESCE(count_on_hand, 0), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
      FROM variants
    SQL

    remove_column :variants, :count_on_hand
  end

  def down
    add_column :variants, :count_on_hand, :integer

    execute <<~SQL.squish
      UPDATE variants
      SET count_on_hand = (
        SELECT inventories.count_on_hand
        FROM inventories
        WHERE inventories.variant_id = variants.id
      )
    SQL

    drop_table :inventories
  end
end
