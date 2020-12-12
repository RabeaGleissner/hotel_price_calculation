# frozen_string_literal: true

require 'httparty'

module Services
  class Request
    def self.get(url)
      HTTParty.get(url).parsed_response
    end
  end
end
