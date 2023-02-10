FactoryBot.define do
  factory :invoice_item do
    :item
    :invoice
    quantity { Faker::Number.number(digits: 3) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end