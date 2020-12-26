class Price < ApplicationRecord
  belongs_to :variant
  has_one :phone, through: :variant
end
