# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order do
  it 'has a valid factory' do
    expect(build(:order)).to be_valid
  end

  describe 'Order validations for build' do
    let(:order) { build(:order) }

    it { expect(order).to validate_presence_of(:order_date) }
  end

  describe 'Order validations for create' do
    let(:order) { create(:order) }

    it { expect(order).to validate_presence_of(:order_total) }
    it { expect(order).to validate_presence_of(:number) }
    it { expect(order).to validate_presence_of(:order_date) }
  end

  describe 'Order associations' do
    let(:order) { build(:order) }

    it { expect(order).to belong_to(:customer) }
    it { expect(order).to have_many(:order_items) }
  end

  context 'Order callbacks' do
    let(:order) { create(:order) }

    it { expect(order).to callback(:create_number).before(:validation).on(:create) }
    it { expect(order).to callback(:set_total_sum).before(:validation).on(:create) }
  end

  describe 'Order instance methods' do
    let(:customer) { create(:customer) }
    let!(:order) { create(:order, customer: customer) }

    context 'responds to its methods' do
      it { expect(order).to respond_to(:recalculate_order_total_sum) }
    end

    context '#recalculate_order_total_sum' do
      it 'when correctly' do
        old_total_order = order.order_total
        order.order_items << create(:order_item)
        order.recalculate_order_total_sum
        expect(order.order_total).to eq(old_total_order + order.order_items.last.calculate_sum)
      end
    end
  end

  describe 'on delete' do
    context 'when order items exist' do
      let!(:order) { create :order }

      it 'deletes all order items' do
        order.order_items << create(:order_item, order: order)
        expect { order.order_items.destroy_all }.to change { order.order_items.count }.to(0)
      end
    end

    context 'when order items exist' do
      let!(:order) { create :order }

      it 'deletes one order item' do
        order.order_items << create_list(:order_item, 3, order: order)
        count = order.order_items.count
        expect { order.order_items.last.destroy }.to change { order.order_items.count }.to(count - 1)
      end
    end
  end
end
