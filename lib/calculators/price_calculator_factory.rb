# frozen_string_literal: true

require_relative 'standard_price_calculator'
require_relative 'tenant_c_price_calculator'

module Calculators
  class PriceCalculatorFactory
    def initialize(tenant_id)
      @tenant_id = tenant_id.downcase.to_sym
    end

    def create
      price_calculators = {
        a: StandardPriceCalculator.new(15, 10, 1000),
        b: StandardPriceCalculator.new(0, 25, 500),
        c: TenantCPriceCalculator.new
      }
      price_calculators[@tenant_id]
    end
  end
end
