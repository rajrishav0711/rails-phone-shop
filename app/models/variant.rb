# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :phone
  has_one :price, dependent: :destroy
  has_one :inventory, dependent: :destroy, autosave: true, inverse_of: :variant

  after_initialize :ensure_inventory

  validates :storage, :color, :count_on_hand, presence: true
  validates :phone_id, uniqueness: { scope: %i[storage color] }
  validate :count_on_hand_must_be_valid

  def name
    "#{color} - #{storage}"
  end

  def count_on_hand
    inventory&.count_on_hand
  end

  def count_on_hand=(value)
    ensure_inventory.count_on_hand = value
  end

  private

  def ensure_inventory
    inventory || build_inventory
  end

  def count_on_hand_must_be_valid
    return if inventory.blank? || inventory.valid?

    inventory.errors.each do |error|
      errors.add(error.attribute, error.message)
    end
  end
end
