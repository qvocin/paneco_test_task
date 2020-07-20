# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Customer.destroy_all

# create 400 customers
400.times do
  Customer.find_or_create_by(email: Faker::Internet.unique.email, date_of_birth: Faker::Date.birthday)
end

# create 1000 orders with random exist customers and random order_items
1000.times do
  order = Order.create!(order_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
                        customer_id: Customer.order(Arel.sql('RANDOM()')).first.id)
  rand(1..4).times do
    order_item = OrderItem.create!(product_name: Faker::Commerce.product_name,
                                   quantity: rand(1..5),
                                   price: Faker::Commerce.price(range: 1..100.0),
                                   order_id: order.id)
    order.order_items << order_item
  end
  order.order_total = order.order_items.inject(0) { |sum, item| sum + item.calculate_sum }
  order.save!
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

p 'Finish'