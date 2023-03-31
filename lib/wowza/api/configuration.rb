class Wowza::Api::Configuration
  attr_accessor :api_key, :access_key, :version, :hostname

  def initialize
    @api_key    = ENV["WSC_API_KEY"]
    @access_key = ENV["WSC_API_ACCESS_KEY"]
    @hostname   = 'https://api.cloud.wowza.com/api/v1.6'
    @version    = '1.8'
  end
end