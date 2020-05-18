FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { Faker::Time.backward(days: 10, period: :morning) }
    updated_at { Faker::Time.backward(days: 10, period: :evening) }
  end
end
