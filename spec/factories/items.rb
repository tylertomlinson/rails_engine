FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Movies::Lebowski.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    created_at { Faker::Time.backward(days: 10, period: :morning) }
    updated_at { Faker::Time.backward(days: 10, period: :evening) }
    association :merchant, factory: :merchant
  end
end
