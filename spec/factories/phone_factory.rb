# frozen_string_literal: true

FactoryGirl.define do
  factory :phone do
    sequence(:manufacturer) { |n| "Apple-#{n}" }
    model { 'Iphone 11' }
    manufacture_year { 2019 }
  end
end
