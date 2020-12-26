# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :phone
  has_one :price

  validates :storage, :color, :count_on_hand, presence: true
  validates :count_on_hand, numericality: { greater_than_or_equal_to: 0 }
  validates :phone_id, uniqueness: { scope: %i[storage color] }
end
