# frozen_string_literal: true

require 'sinatra'
require_relative 'services/hotel_supplier_service'
require_relative 'calculators/price_calculator'

class HotelPriceCalculatorApp < Sinatra::Base
  get '/hotels/price' do
    tenant_id = params[:tenant_id]
    unless tenant_id
      status 400
    end
    prices = Services::HotelSupplierService.new.retrieve_hotel_prices
    Calculators::PriceCalculator.new(tenant_id, prices).calculate
  end
end
