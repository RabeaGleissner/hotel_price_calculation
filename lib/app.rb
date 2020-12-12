# frozen_string_literal: true

require 'sinatra'
require_relative 'services/hotel_supplier_service'
require_relative 'calculators/price_calculator'

class HotelPriceCalculatorApp < Sinatra::Base
  get '/hotels/price' do
    prices = Services::HotelSupplierService.new.retrieve_hotel_prices
    Calculators::PriceCalculator.new(params[:tenant_id], prices).calculate
  end
end
