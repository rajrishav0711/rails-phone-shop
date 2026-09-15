# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    sequence(:manufacturer) { |n| "Apple-#{n}" }
    model { "iPhone 11" }
    manufacture_year { 2019 }
  end
end
