# frozen_string_literal: true

ActiveAdmin.register Customer do
  menu priority: 2
  actions :index

  index do
    column :email
    column :date_of_birth
    column :created_at
  end
end
