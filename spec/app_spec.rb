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
  let(:price_calculator) { instance_spy(Calculators::PriceCalculator) }

  before(:each) do
    allow(Services::HotelSupplierService).to receive(:new).and_return(hotel_supplier_service)
    allow(Calculators::PriceCalculator).to receive(:new).and_return(price_calculator)
  end

  it 'retrieves the hotel prices' do
    get '/hotels/price?tenant_id=A'

    expect(last_response.status).to eq(200)
    expect(Services::HotelSupplierService).to have_received(:new)
    expect(hotel_supplier_service).to have_received(:retrieve_hotel_prices)
  end

  it 'calculates prices based on tenant id and hotel prices from service' do
    prices = { hotels: [{ id: 12, price: 100 }, { id: 98, price: 200 }] }
    allow(hotel_supplier_service).to receive(:retrieve_hotel_prices).and_return(prices)

    get '/hotels/price?tenant_id=A'

    expect(last_response.status).to eq(200)
    expect(Calculators::PriceCalculator).to have_received(:new).with('A', prices)
    expect(price_calculator).to have_received(:calculate)
  end

  it 'errors when no tenant id is given' do
    get '/hotels/price'

    expect(last_response.status).to eq(400)
  end
end
