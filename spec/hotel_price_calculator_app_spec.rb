# frozen_string_literal: true

require 'rspec'
require 'rack/test'
require 'json'
require_relative '../lib/hotel_price_calculator_app'

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

  context 'error responses' do
    it 'errors when no tenant id is given' do
      get '/hotels/price'

      expect(last_response.status).to eq(400)
    end

    it 'errors when no hotel prices are returned from hotel supplier' do
      allow(hotel_supplier_service).to receive(:retrieve_hotel_prices).and_return([])
      get '/hotels/price?tenant_id=A'

      expect(last_response.status).to eq(404)
    end
  end

  context 'with prices returned from hotel supplier service' do
    prices = { hotels: [{ id: 'ab12', price: 100 }, { id: 'xy98', price: 200 }] }

    before(:each) do
      allow(hotel_supplier_service).to receive(:retrieve_hotel_prices).and_return(prices)
    end

    it 'retrieves the hotel prices' do
      get '/hotels/price?tenant_id=A'

      expect(last_response.status).to eq(200)
      expect(Services::HotelSupplierService).to have_received(:new)
      expect(hotel_supplier_service).to have_received(:retrieve_hotel_prices)
    end

    it 'calculates prices based on tenant id and hotel prices from service' do
      get '/hotels/price?tenant_id=A'

      expect(last_response.status).to eq(200)
      expect(Calculators::PriceCalculator).to have_received(:new).with('A')
      expect(price_calculator).to have_received(:calculate).with(prices)
    end

    it 'returns new prices for tenant' do
      response = [{ hotel_id: '124', price: 129.5 }]
      allow(Calculators::PriceCalculator).to receive(:new).with('A').and_return(price_calculator)
      allow(price_calculator).to receive(:calculate).and_return(response)

      get '/hotels/price?tenant_id=A'

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(JSON.generate(response))
    end
  end
end
