# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order, foreign_key: :order_id, optional: true

  validates :product_name, :quantity, :price, presence: true
  validates  :quantity, numericality: { greater_than: 0, only_integer: true }
  validates  :price, numericality: { greater_than_or_equal_to: 0.01, only_decimal: true }

  after_save :recalculate_order_total
  after_destroy :recalculate_order_total

  def calculate_sum
    quantity * price
  end

  private

  def recalculate_order_total
    order.recalculate_order_total_sum
  end
end
