# frozen_string_literal: true

require 'calculators/price_calculator_factory'

describe Calculators::PriceCalculatorFactory do
  context 'calculator for tenant A' do
    let(:factory) { Calculators::PriceCalculatorFactory.new('A') }

    it 'gets the standard price calculator for tenant A' do
      price_calculator = factory.create

      expect(price_calculator).to be_a(Calculators::StandardPriceCalculator)
    end

    it 'instantiates price calculator for tenant A with correct values' do
      allow(Calculators::StandardPriceCalculator).to receive(:new)

      factory.create

      expect(Calculators::StandardPriceCalculator).to have_received(:new).with(15, 10, 1000)
    end
  end

  context 'calculator for tenant B' do
    let(:factory) { Calculators::PriceCalculatorFactory.new('B') }

    it 'gets the standard price calculator for tenant B' do
      price_calculator = factory.create

      expect(price_calculator).to be_a(Calculators::StandardPriceCalculator)
    end

    it 'instantiates price calculator for tenant B with correct values' do
      allow(Calculators::StandardPriceCalculator).to receive(:new)

      factory.create

      expect(Calculators::StandardPriceCalculator).to have_received(:new).with(0, 25, 500)
    end
  end

  context 'calculator for tenant C' do
    let(:factory) { Calculators::PriceCalculatorFactory.new('C') }

    it 'gets the calculator for tenant C' do
      price_calculator = factory.create

      expect(price_calculator).to be_a(Calculators::TenantCPriceCalculator)
    end

    it 'instantiates calculator for tenant C' do
      allow(Calculators::TenantCPriceCalculator).to receive(:new)

      factory.create

      expect(Calculators::TenantCPriceCalculator).to have_received(:new)
    end
  end
end
