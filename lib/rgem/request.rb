require 'net/https'
require 'uri'
require 'json'

module Rgem
  module Request

    def self.post(url, body)
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type': 'application/json'})
      request.body = body.to_json
      https.request(request)
    end

  end
end
