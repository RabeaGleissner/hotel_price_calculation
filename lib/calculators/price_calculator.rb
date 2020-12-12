# frozen_string_literal: true

module Calculators
  class PriceCalculator
    def initialize(tenant_id, hotel_prices)
      @tenant_id = tenant_id
      @hotel_prices = hotel_prices
    end

    def calculate
      true
    end
  end
end
