require 'logger'
require "./lib/wowza2/api/version"
require "./lib/wowza2/api/base"
require "./lib/wowza2/api/transcoder"
require "./lib/wowza2/api/recording"
require "./lib/wowza2/api/vod_stream"
require "./lib/wowza2/api/stream_target/base"
require "./lib/wowza2/api/stream_target/akamai"
require "./lib/wowza2/api/stream_target/wowza_cdn"
require "./lib/wowza2/api/stream_target/custom"
require "./lib/wowza2/api/stream_target/facebook"
require './lib/wowza2/api/output'
require './lib/wowza2/api/output_list'
require './lib/wowza2/api/stream_target_list'
require './lib/wowza2/api/configuration'

module Wowza2
  module Api
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Wowza2::Api::Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    class Error < StandardError; end

  end
end
