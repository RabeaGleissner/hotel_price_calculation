# frozen_string_literal: true

require 'services/hotel_supplier_service'

describe Services::HotelSupplierService do
  let(:hotel_supplier_service) { Services::HotelSupplierService.new }
  let(:hotel_prices) { { hotels: [{ id: 'ab12', price: 100 }, { id: 'xy98', price: 200 }] } }

  before(:each) do
    allow(Services::Request).to receive(:get).and_return(hotel_prices)
  end

  it 'returns an array of ids and prices' do
    response = hotel_supplier_service.retrieve_hotel_prices
    expect(response).to eq([{ id: 'ab12', price: 100 }, { id: 'xy98', price: 200 }])
  end
end
