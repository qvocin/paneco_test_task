# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    product_name { Faker::Commerce.product_name }
    quantity { rand(1..5) }
    price { Faker::Commerce.price(range: 1..100.0) }
    order

    trait :order_item_price_more_50 do
      price { 50.00 }
      quantity { 2 }
    end

    trait :order_item_price_less_50 do
      price { 5.00 }
      quantity { 1 }
    end
  end
end
