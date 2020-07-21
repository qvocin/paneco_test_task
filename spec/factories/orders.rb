# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    order_date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    customer

    trait :order_item_price_more_50 do
      after :build do |order|
        order.order_items << build(:order_item, :order_item_price_more_50, order: order)
      end
    end

    trait :order_price_less_50 do
      after :build do |order|
        order.order_items << build(:order_item, :order_item_price_less_50, order: order)
      end
    end
  end
end
