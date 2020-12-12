# frozen_string_literal: true

require 'services/hotel_supplier_service'

describe Services::HotelSupplierService do
  let(:hotel_supplier_service) { Services::HotelSupplierService.new }

  it 'returns an array of ids and prices' do
    hotel_prices = { 'hotels' => [{ 'id' => 'ab12', 'price' => 100 }, { 'id' => 'xy98', 'price' => 200 }] }
    allow(Services::Request).to receive(:get).and_return(hotel_prices)

    response = hotel_supplier_service.retrieve_hotel_prices

    expect(response).to eq([{ id: 'ab12', price: 100 }, { id: 'xy98', price: 200 }])
  end

  it 'returns empty array when API response does not have the expected hotel key' do
    badly_formed_response = { 'buildings' => [{ 'id' => 'ab12', 'price' => 100 }, { 'id' => 'xy98', 'price' => 200 }] }
    allow(Services::Request).to receive(:get).and_return(badly_formed_response)

    response = hotel_supplier_service.retrieve_hotel_prices

    expect(response).to eq([])
  end

  it 'removes inclomplete hashes' do
    badly_formed_response = { 'hotels' => [{ 'id' => 'ab12' }, { 'price' => 3 }, { 'id' => 'xy98', 'price' => 200 }] }
    allow(Services::Request).to receive(:get).and_return(badly_formed_response)

    response = hotel_supplier_service.retrieve_hotel_prices

    expect(response).to eq([{ id: 'xy98', price: 200 }])
  end
end
