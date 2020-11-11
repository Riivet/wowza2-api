module Wowza::Api
  module StreamTarget
    class Base < Wowza::Api::Base
      def self.list
        response = get('/stream_targets')
        if response['stream_targets']
          response['stream_targets'].map{|r| new(r) }
        end
      end

      def properties
        response = get("/stream_targets/#{id}/properties")
        if response['properties']
          return response['properties']
        end
      end
    end
  end
end
