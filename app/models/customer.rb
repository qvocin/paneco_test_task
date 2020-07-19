# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :orders, foreign_key: :customer_id, dependent: :destroy

  validates :email, uniqueness: true, presence: true
  validates :date_of_birth, presence: true
end
