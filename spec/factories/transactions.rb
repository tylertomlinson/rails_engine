FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { '' }
    result { 'success' }
    association :invoice, factory: :invoice
  end
end
