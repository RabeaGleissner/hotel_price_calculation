# frozen_string_literal: true

require 'sinatra'
require_relative 'services/hotel_supplier_service'
require_relative 'calculators/price_calculator'

class HotelPriceCalculatorApp < Sinatra::Base
  get '/hotels/price' do
    tenant_id = params[:tenant_id]
    unless tenant_id
      return status 400
    end

    prices = Services::HotelSupplierService.new.retrieve_hotel_prices
    if prices.empty?
      return status 404
    end

    Calculators::PriceCalculator.new(tenant_id).calculate(prices).to_json
  end
end
