# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customer page' do
  let!(:admin_user) { create :admin_user }

  before do
    login_as(admin_user, scope: :admin_user)
  end

  scenario 'visit to customer index page without customers' do
    visit admin_customers_path
    expect(page).to have_content('Logout')
    expect(page).to have_content(admin_user.email)
    expect(page).to have_content('There are no Customers yet')
  end

  scenario 'visit to customer index page with customer' do
    customer = create(:customer)
    visit admin_customers_path
    expect(page).to have_content('Logout')
    expect(page).to have_content(admin_user.email)
    expect(page).to have_content(customer.email)
  end
end
