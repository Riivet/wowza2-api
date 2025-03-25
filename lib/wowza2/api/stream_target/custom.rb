class Wowza2::Api::StreamTarget::Custom < Wowza2::Api::StreamTarget::Base
  DEFAULT_OPTIONS = {
    provider: 'rtmp'
  }

  def self.list
    response = get('/stream_targets/custom')
    if response['stream_targets_custom']
      response['stream_targets_custom'].map{|r| new(r) }
    end
  end

  def self.retrieve(id)
    response = get("/stream_targets/custom/#{id}")
    if response['stream_target_custom']
      new(response['stream_target_custom'])
    end
  end

  def self.create(opts={})
    data = DEFAULT_OPTIONS.merge(opts)
    response = post('/stream_targets/custom', stream_target_custom: data)
    if response['stream_target_custom']
      new(response['stream_target_custom'])
    end
  end

  def update(data={})
    response = put("/stream_targets/custom/#{id}", stream_target_custom: data)
    if response['stream_target_custom']
      @data = response['stream_target_custom']
    end
  end

  def destroy
    response = delete("/stream_targets/custom/#{id}")
    return true if response
    return response
  end
end
