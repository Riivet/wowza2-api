class Wowza::Api::Output < Wowza::Api::Base
  def initialize(transcoder_id, data)
    @data = data
    @transcoder_id = transcoder_id
  end

  def width
    aspect_ratio_width
  end

  def height
    aspect_ratio_height
  end

  def stream_targets
    return @stream_target_list if @stream_target_list
    Wowza::Api::StreamTargetList.new(transcoder_id, id)
  end

  def create(opts={})
  end
end
