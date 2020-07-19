# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer, foreign_key: :customer_id
  has_many :order_items, foreign_key: :order_id, dependent: :destroy

  validates :order_date, :order_total, presence: true
  validates :number, uniqueness: true, presence: true
end
