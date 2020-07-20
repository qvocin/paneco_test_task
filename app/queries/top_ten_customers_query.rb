# frozen_string_literal: true
# rubocop:disable Metrics/AbcSize

class TopTenCustomersQuery
  attr_accessor :customers, :orders

  def initialize
    @customers = Customer.arel_table
    @orders = Order.arel_table
  end

  def all
    arel_query = build_arel_query
    ActiveRecord::Base.connection.execute(arel_query.to_sql)
  end

  private

  def build_arel_query
    customers.
      project(customers[:email],
              Arel::Nodes::NamedFunction.new('SUM', [orders[:order_total]]).as('order_total_sum')).
      join(orders).on(customers[:id].eq(orders[:customer_id])).
      where(customers[:id].eq(orders[:customer_id])).
      group(customers[:email]).
      order('order_total_sum DESC').take(10)
  end
end
