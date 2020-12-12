# frozen_string_literal: true

require_relative 'request'

module Services
  class HotelSupplierService
    HOTEL_SUPPLIER_URL = 'http://www.mocky.io/v2/5d99f2ac310000720097da14'

    def retrieve_hotel_prices
      hotel_prices = Request.get(HOTEL_SUPPLIER_URL)
      unless hotel_prices.key?(:hotels)
        return []
      end

      hotel_prices[:hotels].select do |hotel_price|
        (hotel_price.keys & [:id, :price]).length == 2
      end
    end
  end
end
