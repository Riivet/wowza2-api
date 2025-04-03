class Wowza2::Api::StreamTarget::Akamai < Wowza2::Api::StreamTarget::Base

  DEFAULT_OPTIONS = {
    provider: 'akamai_cupertino',
    use_cors: true
  }

  def playback_url
    hls_playback_url
  end

  def self.list
    response = get('/stream_targets/akamai')
    if response['stream_targets_akamai']
      response['stream_targets_akamai'].map{|r| new(r) }
    end
  end

  def self.retrieve(id)
    response = get("/stream_targets/akamai/#{id}")
    if response['stream_target_akamai']
      new(response['stream_target_akamai'])
    end
  end

  def self.create(opts={})
    data = DEFAULT_OPTIONS.merge(opts)
    response = post('/stream_targets/akamai', stream_target_akamai: data)
    if response['stream_target_akamai']
      new(response['stream_target_akamai'])
    end
  end

  def update(data={})
    response = put("/stream_targets/akamai/#{id}", stream_target_akamai: data)
    if response['stream_target_akamai']
      @data = response['stream_target_akamai']
    end
  end

  def destroy
    response = delete("/stream_targets/akamai/#{id}")
    return true if response
    return response
  end
end
