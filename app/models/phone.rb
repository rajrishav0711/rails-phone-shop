# frozen_string_literal: true

class Phone < ApplicationRecord
  has_many :variants, dependent: :destroy
  has_many :prices, through: :variants

  validates :manufacturer, :model, presence: true
  validates :manufacture_year, numericality: { greater_than: 1950, less_than_or_equal_to: 2050 }
  validates :model, uniqueness: { scope: :manufacturer }

  # @returns [String]
  def name
    "#{manufacturer} - #{model}"
  end
end
