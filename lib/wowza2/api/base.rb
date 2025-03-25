require 'net/http'
require 'json'

class Wowza2::Api::Base
  API_BASE = 'https://api.video.wowza.com/api/v2.0'

  attr_reader :data

  def method_missing(m, *args, &block)
    @data[m.to_s]
  end

  def initialize(data)
    raise "No Data" unless data
    @data = data
  end

  private

  def self.request(type, endpoint, body = nil)
    uri = URI("#{API_BASE}#{endpoint}")
    byebug
    request = case type
    when :get
      Net::HTTP::Get.new uri.path
    when :post
      Net::HTTP::Post.new uri.path
    when :put
      Net::HTTP::Put.new uri.path
    when :delete
      Net::HTTP::Delete.new uri.path
    when :patch
      Net::HTTP::Patch.new uri.path
    else
      raise "#{type} not found"
    end

    # request['wsc-api-key'] = Wowza2::Api::configuration.api_key
    # request['wsc-access-key'] = Wowza2::Api::configuration.access_key
    request['Authorization'] = "Bearer: #{Wowza2::Api::configuration.jwt}"
    request['Content-Type'] = 'application/json'
    body = body.is_a?(Hash) ? body.to_json : body.to_s
    request.body = body if body

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      response = http.request(request)

      uri_regex = Wowza2::Api.configuration.logger_filter.is_a?(Hash) ? Wowza2::Api.configuration.logger_filter[type] : Wowza2::Api.configuration.logger_filter
      if Wowza2::Api.configuration.logger && (Wowza2::Api.configuration.logger_filter.nil? || uri.path =~ uri_regex)
        msg = "\n#{type.upcase} #{uri}\n----------------\n#{body}\n----------------\n#{response.code} #{response.body}\n----------------\n\n"
        Wowza2::Api.configuration.logger.debug(msg)
      end
      result = JSON.parse(response.body) if response.body
      if response.code =~ /^2/
        return response.body ? result : true
      else
        raise Wowza2::Api::Error.new(result.dig('meta','message'))
      end
    end

  end

  def self.get(endpoint)
    request(:get, endpoint)
  end

  def self.post(endpoint, body)
    request(:post, endpoint, body)
  end

  def get(endpoint)
    self.class.request(:get, endpoint)
  end

  def post(endpoint, body)
    self.class.request(:post, endpoint, body)
  end

  def put(endpoint, body={})
    self.class.request(:put, endpoint, body)
  end

  def patch(endpoint, body={})
    self.class.request(:patch, endpoint, body)
  end

  def delete(endpoint)
    self.class.request(:delete, endpoint)
  end
end
