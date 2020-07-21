# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    email { Faker::Internet.unique.email }
    date_of_birth { Faker::Date.birthday }

    trait :with_order_where_total_more_than_50 do
      date_of_birth { 20.year.ago }
      after(:create) do |customer|
        FactoryBot.create_list(:order, 2, :order_item_price_more_50, customer: customer)
      end
    end

    trait :with_order_where_total_less_than_50 do
      date_of_birth { 40.year.ago }
      after(:create) do |customer|
        FactoryBot.create_list(:order, 1, :order_price_less_50, customer: customer)
      end
    end
  end
end
