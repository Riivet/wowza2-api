class Wowza::Api::Transcoder < Wowza::Api::Base
  DEFAULT_OPTIONS = {
    billing_mode: 'pay_as_you_go',
    transcoder_type: 'transcoded',
    delivery_method: 'push',
    protocol: 'rtmp',
    recording: true,
    closed_caption_type: 'none',
    disable_authentication: true,
    buffer_size: 8000,
    idle_timeout: 1200,
    stream_smoother: false
  }.freeze

  def self.list
    response = get('/transcoders')
    if response['transcoders']
      response['transcoders'].map{|r| new(r) }
    end
  end

  def self.retrieve(id)
    response = get("/transcoders/#{id}")
    if response['transcoder']
      new(response['transcoder'])
    end
  end

  def self.create(opts={})
    data = DEFAULT_OPTIONS.merge(opts)
    response = post('/transcoders', transcoder: data)
    if response['transcoder']
      new(response['transcoder'])
    end
  end

  def update(data={})
    response = put("/transcoders/#{id}", transcoder: data)
    if response['transcoder']
      @data = response['transcoder']
    end
  end

  def destroy
    response = delete("/transcoders/#{id}")
    return true if response
  end

  def rtmp_playback_url
    list = @data.dig('direct_playback_urls', 'rtmp')
    list.find{|k| k['name'] == 'source' }.dig('url')
  end

  # TODO
  # 1. update/delete output
  # 2. create, remove, destroy stream_target from output

  def properties
    response = get("/transcoders/#{id}/properties")
    ret = Hash.new{ |h,k| h[k] = {} }
    response.dig('properties').each do |item|
      ret[item['section']][item['key']] = item['value']
    end
    return ret
  end

  def property(section, key, value)
    data = {
      section: section,
      key: key,
      value: value
    }
    response = post("/transcoders/#{id}/properties", property: data)
  end

  def remove_property(section, key)
    response = delete("/transcoders/#{id}/properties/#{section}-#{key}")
  end

  def thumbnail
    response = get("/transcoders/#{id}/thumbnail_url")
    return response.dig('transcoder','thumbnail_url') if response.dig('transcoder')
  end

  def state
    response = get("/transcoders/#{id}/state")
    return response.dig('transcoder','state') if response.dig('transcoder')
  end

  def start
    response = put("/transcoders/#{id}/start")
    return response.dig('transcoder','state') if response.dig('transcoder')
  end

  def stop
    response = put("/transcoders/#{id}/stop")
    return response.dig('transcoder','state') if response.dig('transcoder')
  end

  def stats
    response = get("/transcoders/#{id}/stats")
    ret = {}
    if response['transcoder']
      response['transcoder'].each do |k,v|
        ret[k] = v.dig('value')
      end
      return ret
    end
  end

  def recordings
    response = get("/transcoders/#{id}/recordings")
    response['recordings'].map do |r|
      Wowza::Api::Recording.retrieve(r['id'])
    end
  end

  # Outputs
  def outputs
    @output_list || Wowza::Api::OutputList.new(id, @data['outputs'])
  end

  def update_output
  end

  def delete_output
  end

end
