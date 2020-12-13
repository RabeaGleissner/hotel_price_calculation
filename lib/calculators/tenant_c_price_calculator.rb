# frozen_string_literal: true

module Calculators
  class TenantCPriceCalculator
    MAX_COST_PRICE = 1000

    THRESHOLDS_WITH_NEW_PRICES = {
      [0, 200] => 250,
      [201, 500] => 800,
      [501, 1000] => 1500
    }.freeze

    def calculate(hotels_with_prices)
      hotels_with_prices.each_with_object([]) do |hotel_with_price, new_price_list|
        cost_price = hotel_with_price[:price]
        unless cost_price > MAX_COST_PRICE
          new_price_list << { hotel_id: hotel_with_price[:id], price: new_price(cost_price) }
        end
      end
    end

    def new_price(cost_price)
      THRESHOLDS_WITH_NEW_PRICES.each do |threshold, new_price|
        if cost_price >= threshold[0] && cost_price <= threshold[1]
          return new_price.to_f
        end
      end
    end
  end
end
