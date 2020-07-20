# frozen_string_literal: true
# rubocop:disable Metrics/AbcSize

class TopTenCustomersQuery
  attr_accessor :customers, :orders, :age

  def initialize(data)
    @customers = Customer.arel_table
    @orders = Order.arel_table
    @age = data[:age].to_i
  end

  def top_10
    arel_query = build_arel_query
    ActiveRecord::Base.connection.execute(arel_query.to_sql)
  end

  private

  def build_arel_query
    customers.
      project(customers[:email], customers[:date_of_birth],
              Arel::Nodes::NamedFunction.new('SUM', [orders[:order_total]]).as('order_total_sum')).
      join(orders).on(customers[:id].eq(orders[:customer_id])).
      where(where_conditions).
      group(customers[:email], customers[:date_of_birth]).
      order('order_total_sum DESC').take(10)
  end

  def where_conditions
    query = customers[:id].eq(orders[:customer_id])
    query = query.and(customers[:date_of_birth].lteq(@age.years.ago)) if @age.present? && @age.positive?
    query
  end
end
