# frozen_string_literal: true

require 'calculators/standard_price_calculator'

describe Calculators::StandardPriceCalculator do
  let(:prices) do
    [
      { id: 'xYhd', price: 120 },
      { id: 'kDlX', price: 480 },
      { id: '82Dx', price: 850 },
      { id: 'zXDm', price: 880 },
      { id: 'Wds8', price: 1200 }
    ]
  end

  it 'adds 15% markup, $10 service fee and removes hotels more expensive than $1000' do
    expected_prices = [
      { hotel_id: 'xYhd', price: 148.0 },
      { hotel_id: 'kDlX', price: 562.0 },
      { hotel_id: '82Dx', price: 987.5 }
    ]
    standard_price_calculator = Calculators::StandardPriceCalculator.new(prices, 15, 10, 1000)

    expect(standard_price_calculator.calculate).to eq(expected_prices)
  end

  it 'adds $25 service fee and removes hotels more expensive than $500' do
    expected_prices = [{ hotel_id: 'xYhd', price: 145 }]
    standard_price_calculator = Calculators::StandardPriceCalculator.new(prices, 0, 25, 500)

    expect(standard_price_calculator.calculate).to eq(expected_prices)
  end
end
