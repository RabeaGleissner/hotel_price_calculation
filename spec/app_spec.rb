# frozen_string_literal: true

require 'rspec'
require 'rack/test'
require_relative '../lib/app'

describe HotelPriceCalculatorApp do
  include Rack::Test::Methods
  def app
    HotelPriceCalculatorApp.new
  end

  let(:hotel_supplier_service) { instance_spy(Services::HotelSupplierService) }

  before(:each) do
    allow(Services::HotelSupplierService).to receive(:new).and_return(hotel_supplier_service)
  end

  it 'retrieves the hotel prices' do
    get '/hotels/price'

    expect(Services::HotelSupplierService).to have_received(:new)
    expect(hotel_supplier_service).to have_received(:retrieve_hotel_prices)
  end
end
