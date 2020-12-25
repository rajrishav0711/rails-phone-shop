# frozen_string_literal: true

class Phone < ApplicationRecord
  validates :manufacturer, :model, presence: true
  validates :manufacture_year, numericality: { greater_than: 1950, less_than_or_equal_to: 2050 }
  validates :model, uniqueness: { scope: :manufacturer }
end
