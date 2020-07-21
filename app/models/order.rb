# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer, foreign_key: :customer_id
  has_many :order_items, foreign_key: :order_id, dependent: :destroy, inverse_of: :order

  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :order_date, :order_total, presence: true
  validates :number, uniqueness: true, presence: true

  before_validation :create_number, :set_total_sum, on: :create

  def recalculate_order_total_sum
    update!(order_total: calculate_order_items_sum)
  end

  private

  def create_number
    last_id = Order.count || 0
    self.number = format('Order-%.6d', last_id + 1)
  end

  def set_total_sum
    self.order_total = calculate_order_items_sum
  end

  def calculate_order_items_sum
    order_items.inject(0) { |sum, item| sum + item.calculate_sum }
  end
end
