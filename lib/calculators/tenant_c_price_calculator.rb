# frozen_string_literal: true

module Calculators
  class TenantCPriceCalculator
    MAX_COST_PRICE = 1000

    THRESHOLDS_WITH_NEW_PRICES = {
      [0, 200] => 250,
      [201, 300] => 800,
      [501, 1000] => 1500
    }.freeze

    def calculate(prices_per_hotel)
      prices_per_hotel.each_with_object([]) do |hotel_price, new_price_list|
        unless hotel_price[:price] > MAX_COST_PRICE
          new_price_list << { hotel_id: hotel_price[:id], price: new_price(hotel_price[:price]) }
        end
      end
    end

    def new_price(price)
      THRESHOLDS_WITH_NEW_PRICES.each do |threshold, new_price|
        if price >= threshold[0] && price <= threshold[1]
          return new_price
        end
      end
    end
  end
end
