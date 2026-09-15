# frozen_string_literal: true

apple = Phone.create!(
  manufacturer: 'Apple',
  model: 'Iphone XR',
  manufacture_year: 2018
)

samsung = Phone.create!(
  manufacturer: 'Samsung',
  model: 'S2',
  manufacture_year: 2011
)

Variant.create!([
  { phone: samsung, storage: '128 GB', color: 'Blue', count_on_hand: 600 },
  { phone: samsung, storage: '64 GB', color: 'Blue', count_on_hand: 200 },
  { phone: apple, storage: '64 GB', color: 'Black', count_on_hand: 200 }
])