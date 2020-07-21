# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopTenCustomersQuery do
  describe '#top_10 report' do
    let(:query) { described_class.new({}) }
    let!(:query_with_age) do
      data = {}
      data['age'] = '30'
      described_class.new(data)
    end

    context 'responds to its methods' do
      it { expect(query).to respond_to(:top_10) }
    end

    # create 10 customers (customers_more_50_order_total) with order total more than 10 another customers for checking
    # but customers_less_50_order_total have age more than 30 age

    let!(:customers_more_50_order_total) { create_list(:customer, 10, :with_order_where_total_more_than_50) }
    let!(:customers_less_50_order_total) { create_list(:customer, 10, :with_order_where_total_less_than_50) }

    context 'report without params age' do
      subject { query.top_10 }

      it 'query responce size equal 10' do
        expect(subject.to_a.size).to eq(10)
      end

      it 'query responce include keys' do
        keys = %w[email date_of_birth order_total_sum]
        keys_from_responce = subject.to_a.first.keys
        keys.each { |key| expect(keys_from_responce).to include(key) }
        expect(subject.to_a.size).to eq(10)
      end

      it 'query responce include customers more 50 order total' do
        emails_from_repsonce = subject.to_a.map { |data| data['email'] }
        customers_more_50_order_total.collect(&:email).each do |email|
          expect(emails_from_repsonce).to include(email)
        end
      end

      it 'query responce has not customers less 50 order total' do
        emails_from_repsonce = subject.to_a.map { |data| data['email'] }
        customers_less_50_order_total.collect(&:email).each do |email|
          expect(emails_from_repsonce).not_to include(email)
        end
      end
    end

    context 'report with params age oplder than 30 years' do
      subject { query_with_age.top_10 }

      it 'query responce size equal 10' do
        expect(subject.to_a.size).to eq(10)
      end

      it 'query responce include keys' do
        keys = %w[email date_of_birth order_total_sum]
        keys_from_responce = subject.to_a.first.keys
        keys.each { |key| expect(keys_from_responce).to include(key) }
        expect(subject.to_a.size).to eq(10)
      end

      it 'query responce include customers more 50 order total' do
        emails_from_repsonce = subject.to_a.map { |data| data['email'] }
        customers_less_50_order_total.collect(&:email).each do |email|
          expect(emails_from_repsonce).to include(email)
        end
      end

      it 'query responce has not customers less 50 order total' do
        emails_from_repsonce = subject.to_a.map { |data| data['email'] }
        customers_more_50_order_total.collect(&:email).each do |email|
          expect(emails_from_repsonce).not_to include(email)
        end
      end
    end
  end
end
