# frozen_string_literal: true

require 'calculators/tenant_c_price_calculator'

describe Calculators::TenantCPriceCalculator do
  let(:tenant_c_price_calculator) { Calculators::TenantCPriceCalculator.new }

  it 'sets price to 250 if the hotel price is between 0 and 200' do
    prices = [{ id: 'xyz', price: 100 }]

    expect(tenant_c_price_calculator.calculate(prices)).to eq([{ hotel_id: 'xyz', price: 250.0 }])
  end

  it 'sets price to 800 if the hotel price is between 201 and 500' do
    prices = [{ id: 'xyz', price: 300 }]

    expect(tenant_c_price_calculator.calculate(prices)).to eq([{ hotel_id: 'xyz', price: 800.0 }])
  end

  it 'sets price to 1500 if the hotel price is between 501 and 1000' do
    prices = [{ id: 'xyz', price: 1000 }]

    expect(tenant_c_price_calculator.calculate(prices)).to eq([{ hotel_id: 'xyz', price: 1500.0 }])
  end

  it 'removes hotel from list if original price is above 1000' do
    prices = [{ id: 'xyz', price: 1001 }]

    expect(tenant_c_price_calculator.calculate(prices)).to eq([])
  end
end
