# frozen_string_literal: true

require 'sinatra'
require_relative 'services/hotel_supplier_service'

class HotelPriceCalculatorApp < Sinatra::Base
  get '/hotels/price' do
    Services::HotelSupplierService.new.retrieve_hotel_prices
  end
end
