FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
    created_at { Faker::Time.backward(days: 10, period: :morning) }
    updated_at { Faker::Time.backward(days: 10, period: :evening) }
  end
end
