# frozen_string_literal: true

class Inventory < ApplicationRecord
  belongs_to :variant

  validates :count_on_hand, presence: true
  validates :count_on_hand, numericality: { greater_than_or_equal_to: 0 }
end
