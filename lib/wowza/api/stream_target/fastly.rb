class Wowza::Api::StreamTarget::Fastly < Wowza::Api::StreamTarget::Base

  DEFAULT_OPTIONS = {
  }

  def self.list
    response = get('/stream_targets/fastly')
    if response['stream_targets_fastly']
      response['stream_targets_fastly'].map{|r| new(r) }
    end
  end

  def self.retrieve(id)
    response = get("/stream_targets/fastly/#{id}")
    if response['stream_target_fastly']
      new(response['stream_target_fastly'])
    end
  end

  def self.create(opts={})
    data = DEFAULT_OPTIONS.merge(opts)
    response = post('/stream_targets/fastly', stream_target_fastly: data)
    if response['stream_target_fastly']
      new(response['stream_target_fastly'])
    end
  end

  def update(data={})
    response = put("/stream_targets/fastly/#{id}", stream_target_fastly: data)
    if response['stream_target_fastly']
      @data = response['stream_target_fastly']
    end
  end

  def destroy
    response = delete("/stream_targets/fastly/#{id}")
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
