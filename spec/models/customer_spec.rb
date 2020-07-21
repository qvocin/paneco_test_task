# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  it 'has a valid factory' do
    expect(build(:customer)).to be_valid
  end

  describe 'Customer validations for build' do
    let(:customer) { build(:customer) }

    it { expect(customer).to validate_presence_of(:date_of_birth) }
    it { expect(customer).to validate_presence_of(:email) }
    it { expect(customer).to validate_uniqueness_of(:email) }
  end

  describe 'Customer associations' do
    let(:customer) { build(:customer) }

    it { expect(customer).to have_many(:orders) }
  end
end
