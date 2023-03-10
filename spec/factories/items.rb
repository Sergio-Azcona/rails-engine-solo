FactoryBot.define do
  factory :item do
    merchant #foreign key
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.material }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    # merchant_id { Faker::Number.between(from: 1, to: 100) }
  end
end