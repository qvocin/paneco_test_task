# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order, foreign_key: :order_id

  validates :product_name, :quantity, :price, presence: true

  def calculate_sum
    quantity * price
  end
end
