# frozen_string_literal: true

module Calculators
  class SpecialPriceCalculator
    def initialize(tenant_id)
      @tenant_id = tenant_id
    end

    def calculate
      true
    end
  end
end
