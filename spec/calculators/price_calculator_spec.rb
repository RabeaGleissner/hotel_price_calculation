# frozen_string_literal: true

require 'calculators/price_calculator'

describe Calculators::PriceCalculator do
  let(:price_calculator_factory) { instance_spy(Calculators::PriceCalculatorFactory) }
  let(:standard_price_calculator) { instance_spy(Calculators::StandardPriceCalculator) }
  let(:config) { { 'tenant_id' => [] } }

  before(:each) do
    allow(Calculators::PriceCalculatorFactory).to receive(:new).and_return(price_calculator_factory)
    allow(price_calculator_factory).to receive(:create).and_return(standard_price_calculator)
  end

  it 'calls factory to create the right price calculator' do
    price_calculator = Calculators::PriceCalculator.new('B', config)
    price_calculator.calculate([])

    expect(Calculators::PriceCalculatorFactory).to have_received(:new).with('B', config)
  end

  it 'calls price calculator to calculate' do
    prices = []

    price_calculator = Calculators::PriceCalculator.new('B', config)
    price_calculator.calculate(prices)

    expect(standard_price_calculator).to have_received(:calculate).with(prices)
  end
end
