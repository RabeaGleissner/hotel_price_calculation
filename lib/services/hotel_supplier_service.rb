# frozen_string_literal: true

require_relative 'request'

module Services
  class HotelSupplierService
    HOTEL_SUPPLIER_URL = 'http://www.mocky.io/v2/5d99f2ac310000720097da14'

    def retrieve_hotel_prices
      Request.get(HOTEL_SUPPLIER_URL)[:hotels]
    end
  end
end
