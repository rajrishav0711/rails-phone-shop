# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    storage { "250 GB" }
    sequence(:color) { |n| "Color #{n}" }
    count_on_hand { 100 }
    association :phone
  end
end
