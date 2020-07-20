# frozen_string_literal: true

ActiveAdmin.register OrderItem do
  belongs_to :order
  permit_params :product_name, :quantity, :price, :order_id

  index do
    id_column
    column :product_name
    column :quantity
    column :price
  end

  show do
    attributes_table do
      row :product_name
      row :quantity
      row :price
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :product_name
      f.input :quantity
      f.input :price
    end
    f.submit
  end
end
