# frozen_string_literal: true

Phone.create!([
                { manufacturer: 'Apple', model: 'Iphone XR', manufacture_year: 2018 },
                { manufacturer: 'Samsung', model: 'S2', manufacture_year: 2011 }
              ])
Variant.create!([
                  { phone_id: 2, storage: '128 GB', color: 'Blue', count_on_hand: 600 },
                  { phone_id: 2, storage: '64 GB', color: 'Blue', count_on_hand: 200 },
                  { phone_id: 3, storage: '64 GB', color: 'Black', count_on_hand: 200 }
                ])
