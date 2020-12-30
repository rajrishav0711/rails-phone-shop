# frozen_string_literal: true

FactoryGirl.define do
  factory :variant do
    storage { '250 GB' }
    sequence(:color) { |n| "Color #{n}" }
    count_on_hand { 100 }
    association :phone, factory: :phone

    trait :with_phone do
      phone
    end
  end
end
