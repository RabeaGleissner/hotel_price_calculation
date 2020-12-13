# frozen_string_literal: true

require_relative 'standard_price_calculator'
require_relative 'tenant_c_price_calculator'

module Calculators
  class PriceCalculatorFactory
    def initialize(tenant_id, standard_tenants)
      @tenant_id = tenant_id.downcase
      @standard_tenants = standard_tenants
    end

    def create
      if @tenant_id == 'c'
        return TenantCPriceCalculator.new
      end

      StandardPriceCalculator.new(*@standard_tenants[@tenant_id])
    end
  end
end
