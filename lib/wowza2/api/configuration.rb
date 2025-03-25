class Wowza2::Api::Configuration
  attr_accessor :api_key, :access_key, :jwt, :version, :hostname, :logger, :logger_filter

  def initialize
    @api_key    = ENV["WSC_API_KEY"]
    @access_key = ENV["WSC_API_ACCESS_KEY"]
    @hostname   = 'https://api.cloud.wowza.com/api/v2.0'
    @version    = '2.0'
  end
end
