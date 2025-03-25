require 'bundler/setup'
require 'byebug'
Bundler.require

Wowza2::Api.configure do |config|
  config.jwt = ENV['WOWZA_JWT']
  config.logger = Logger.new('wowza.log')
  config.logger_filter = {
    put: /transcoder/,
  }
end
