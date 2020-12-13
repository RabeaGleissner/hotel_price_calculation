# frozen_string_literal: true

require 'rack/test'
require 'json'
require_relative '../../lib/hotel_price_calculator_app'

describe HotelPriceCalculatorApp do
  include Rack::Test::Methods
  def app
    HotelPriceCalculatorApp.new
  end

  it 'retrieves the hotel prices for A' do
    expected_response_body = [
      { 'hotel_id': 'xYhd', 'price': 148.0 },
      { 'hotel_id': 'kDlX', 'price': 562.0 },
      { 'hotel_id': '82Dx', 'price': 987.5 }
    ]

    get '/hotels/price?destination_id=1&check_in=YYYY-MM-DD&check_out=YYYY-MM-DD&guests=2&tenant_id=A'

    expect(last_response.status).to equal(200)
    expect(last_response.body).to eq(JSON.generate(expected_response_body))
  end

  it 'retrieves the hotel prices for B' do
    expected_response_body = [
      { 'hotel_id': 'xYhd', 'price': 145.0 }
    ]

    get '/hotels/price?destination_id=1&check_in=YYYY-MM-DD&check_out=YYYY-MM-DD&guests=2&tenant_id=B'

    expect(last_response.status).to equal(200)
    expect(last_response.body).to eq(JSON.generate(expected_response_body))
  end

  it 'retrieves the hotel prices for C' do
    expected_response_body = [
      { 'hotel_id': 'xYhd', 'price': 250.0 },
      { 'hotel_id': 'kDlX', 'price': 800.0 },
      { 'hotel_id': '82Dx', 'price': 1500.0 },
      { 'hotel_id': 'zXDm', 'price': 1500.0 }
    ]

    get '/hotels/price?destination_id=1&check_in=YYYY-MM-DD&check_out=YYYY-MM-DD&guests=2&tenant_id=C'

    expect(last_response.status).to equal(200)
    expect(last_response.body).to eq(JSON.generate(expected_response_body))
  end
end
