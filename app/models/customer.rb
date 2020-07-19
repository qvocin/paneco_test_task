# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :email, :date_of_birth, presence: true
end
