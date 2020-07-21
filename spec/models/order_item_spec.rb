# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem do
  it 'has a valid factory' do
    expect(build(:order_item)).to be_valid
  end

  describe 'OrderItem validations for build' do
    let(:order_item) { build(:order_item) }

    it { expect(order_item).to validate_presence_of(:product_name) }
    it { expect(order_item).to validate_presence_of(:quantity) }
    it { expect(order_item).to validate_presence_of(:price) }
    it { expect(order_item).to validate_numericality_of(:quantity).is_greater_than(0) }
    it { expect(order_item).to validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }
  end

  describe 'OrderItem associations' do
    let(:order_item) { build(:order_item) }

    it { expect(order_item).to belong_to(:order) }
  end

  context 'OrderItem callbacks' do
    let(:order_item) { create(:order_item) }

    it { expect(order_item).to callback(:recalculate_order_total).after(:create) }
    it { expect(order_item).to callback(:recalculate_order_total).after(:destroy) }
  end

  describe 'OrderItem instance methods' do
    let(:order_item) { create(:order_item) }

    context 'responds to its methods' do
      it { expect(order_item).to respond_to(:calculate_sum) }
    end

    context '#calculate_sum' do
      it 'when correctly' do
        expect(order_item.calculate_sum).to eq(order_item.quantity * order_item.price)
      end
    end
  end
end
