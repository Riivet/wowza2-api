require 'logger'
require "wowza-2-api/api/version"
require "wowza-2-api/api/base"
require "wowza-2-api/api/transcoder"
require "wowza-2-api/api/recording"
require "wowza-2-api/api/vod_stream"
require "wowza-2-api/api/stream_target/base"
require "wowza-2-api/api/stream_target/akamai"
require "wowza-2-api/api/stream_target/wowza_cdn"
require "wowza-2-api/api/stream_target/custom"
require "wowza-2-api/api/stream_target/facebook"
require 'wowza-2-api/api/output'
require 'wowza-2-api/api/output_list'
require 'wowza-2-api/api/stream_target_list'
require 'wowza-2-api/api/configuration'

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
