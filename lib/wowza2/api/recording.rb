class Wowza2::Api::Recording < Wowza2::Api::Base
  def self.list
    response = get('/videos')
    if response['videos']
      response['videos'].map{|r| new(r) }
    end
  end

  def self.retrieve(id)
    response = get("/videos/#{id}")
    if response['video']
      new(response['video'])
    end
  end

  def destroy
    response = delete("/videos/#{id}")
    return true if response
  end
end
