# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order, foreign_key: :order_id, inverse_of: :order_items

  validates :product_name, :quantity, :price, presence: true
  validates  :quantity, numericality: { greater_than: 0, only_integer: true }
  validates  :price, numericality: { greater_than_or_equal_to: 0.01, only_decimal: true }

  after_create  :recalculate_order_total
  after_update  :recalculate_order_total
  after_destroy :recalculate_order_total

  def calculate_sum
    quantity * price
  end

  private

  def recalculate_order_total
    order.recalculate_order_total_sum
  end
end
