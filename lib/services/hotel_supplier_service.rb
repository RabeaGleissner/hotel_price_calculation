# frozen_string_literal: true

require_relative 'request'

module Services
  class HotelSupplierService
    HOTEL_SUPPLIER_URL = 'http://www.mocky.io/v2/5d99f2ac310000720097da14'

    def retrieve_hotel_prices
      hotels_with_prices = Request.get(HOTEL_SUPPLIER_URL)
      unless hotels_with_prices.key?('hotels')
        return []
      end

      hotel_prices_with_complete_data(hotels_with_prices).map do |hotel_with_price|
        hotel_with_price.transform_keys(&:to_sym)
      end
    end

    def hotel_prices_with_complete_data(hotels_with_prices)
      hotels_with_prices['hotels'].select do |hotel_with_price|
        (hotel_with_price.keys & ['id', 'price']).length == 2
      end
    end
  end
end
