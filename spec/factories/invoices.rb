FactoryBot.define do
  factory :invoice do
    status { 'shipped' }
    created_at { Faker::Time.backward(days: 10, period: :morning) }
    updated_at { Faker::Time.backward(days: 10, period: :morning) }
    association :merchant, factory: :merchant
    association :customer, factory: :customer
  end
end
