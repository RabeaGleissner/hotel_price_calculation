# frozen_string_literal: true

module Calculators
  class StandardPriceCalculator
    def initialize(hotel_prices, markup_percent, service_fee, max_price)
      @hotel_prices = hotel_prices
      @markup_percent = markup_percent.to_f
      @service_fee = service_fee
      @max_price = max_price
    end

    def calculate
      @hotel_prices.each_with_object([]) do |hotel_price, new_price_list|
        new_price = calculate_new_price(hotel_price[:price])
        if new_price <= @max_price
          new_price_list << { hotel_id: hotel_price[:id], price: new_price }
        end
      end
    end

    private

    def calculate_new_price(old_price)
      add_markup(old_price) + @service_fee
    end

    def add_markup(old_price)
      old_price + (old_price * (@markup_percent / 100))
    end
  end
end
