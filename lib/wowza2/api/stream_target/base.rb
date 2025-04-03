module Wowza2::Api
  module StreamTarget
    def self.retrieve(id)
      types = [
        Wowza2::Api::StreamTarget::WowzaCdn,
        Wowza2::Api::StreamTarget::Akamai,
        Wowza2::Api::StreamTarget::Custom,
        Wowza2::Api::StreamTarget::Facebook
      ]
      types.each do |type|
        begin
          stream_target = type.retrieve id
          return stream_target
        rescue
        end
      end
      return nil
    end

    class Base < Wowza2::Api::Base
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
