# frozen_string_literal: true

require_relative 'price_calculator_factory'

module Calculators
  class PriceCalculator
    def initialize(tenant_id)
      @price_calculator_factory = PriceCalculatorFactory.new(tenant_id)
    end

    def calculate(prices)
      price_calculator = @price_calculator_factory.create
      price_calculator.calculate(prices)
    end
  end
end
