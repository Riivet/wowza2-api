class Wowza2::Api::StreamTarget::WowzaCdn < Wowza2::Api::StreamTarget::Base

  DEFAULT_OPTIONS = {
  }

  def playback_url
    playback_urls['hls'].first['url']
  end

  def self.list
    response = get('/stream_targets/wowza_cdn')
    if response['stream_targets_wowza_cdn']
      response['stream_targets_wowza_cdn'].map{|r| new(r) }
    end
  end

  def self.retrieve(id)
    response = get("/stream_targets/wowza_cdn/#{id}")
    if response['stream_target_wowza_cdn']
      new(response['stream_target_wowza_cdn'])
    end
  end

  def self.create(opts={})
    data = DEFAULT_OPTIONS.merge(opts)
    response = post('/stream_targets/wowza_cdn', stream_target_wowza_cdn: data)
    if response['stream_target_wowza_cdn']
      new(response['stream_target_wowza_cdn'])
    end
  end

  def update(data={})
    response = put("/stream_targets/wowza_cdn/#{id}", stream_target_wowza_cdn: data)
    if response['stream_target_wowza_cdn']
      @data = response['stream_target_wowza_cdn']
    end
  end

  def destroy
    response = delete("/stream_targets/wowza_cdn/#{id}")
    return true if response
    return response
  end

  # TODO

  def current_viewers
    response = get("/usage/stream_targets/#{id}/live")
    response.dig('stream_target','unique_viewers')
  end

  def usage
  end
end
