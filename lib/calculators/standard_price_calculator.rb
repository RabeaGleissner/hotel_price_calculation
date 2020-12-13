# frozen_string_literal: true

module Calculators
  class StandardPriceCalculator
    def initialize(markup, service_fee, max_price)
      @markup = markup.to_f
      @service_fee = service_fee
      @max_price = max_price
    end

    def calculate(hotels_with_prices)
      hotels_with_prices.each_with_object([]) do |hotel_with_price, new_price_list|
        new_price = calculate_new_price(hotel_with_price[:price])
        if new_price <= @max_price
          new_price_list << { hotel_id: hotel_with_price[:id], price: new_price }
        end
      end
    end

    private

    def calculate_new_price(old_price)
      add_markup(old_price) + @service_fee
    end

    def add_markup(old_price)
      old_price + (old_price * (@markup / 100))
    end
  end
end
