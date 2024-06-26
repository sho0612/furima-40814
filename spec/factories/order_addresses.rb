# spec/factories/order_addresses.rb
FactoryBot.define do
  factory :order_address do
    post_code { '123-4567' } # 固定のフォーマットを使用
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipalities { Faker::Address.city }
    street { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.leading_zero_number(digits: 11) }
    token { 'tok_' + Faker::Alphanumeric.alphanumeric(number: 24) }
  end
end
