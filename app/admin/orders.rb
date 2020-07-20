# frozen_string_literal: true

ActiveAdmin.register Order do
  menu priority: 3
  includes :order_items
  permit_params :order_date, :customer_id, order_items_attributes: %i[id product_name quantity price]

  index do
    id_column
    column :number
    column :order_date
    column :order_total
    column('Customer email') { |order| order.customer.email }
    actions
  end

  show do
    attributes_table do
      row :number
      row :order_date
      row :order_total
      row('Customer email') { |order| order.customer.email }
    end

    panel 'Order items' do
      table_for order.order_items do
        column :id do |item|
          link_to item.id, admin_order_order_item_path(order.id, item.id)
        end
        column :product_name
        column :quantity
        column :price
        column 'Sum', &:calculate_sum
      end
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :order_date, as: :datepicker
      f.input :customer_id,
              as: :select,
              include_blank: false,
              collection: Customer.all.map { |u| [u.email, u.id] }
    end
    f.has_many :order_items do |order_item|
      order_item.input :product_name
      order_item.input :quantity
      order_item.input :price
    end
    f.submit
  end
end
