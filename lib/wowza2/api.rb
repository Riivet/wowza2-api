require 'logger'
require "wowza2/api/version"
require "wowza2/api/base"
require "wowza2/api/transcoder"
require "wowza2/api/recording"
require "wowza2/api/vod_stream"
require "wowza2/api/stream_target/base"
require "wowza2/api/stream_target/akamai"
require "wowza2/api/stream_target/fastly"
require "wowza2/api/stream_target/custom"
require "wowza2/api/stream_target/facebook"
require 'wowza2/api/output'
require 'wowza2/api/output_list'
require 'wowza2/api/stream_target_list'
require 'wowza2/api/configuration'

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
