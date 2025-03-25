class Wowza2::Api::Recording < Wowza2::Api::Base
  def self.list
    response = get('/recordings')
    if response['recordings']
      response['recordings'].map{|r| new(r) }
    end
  end

  def self.retrieve(id)
    response = get("/recordings/#{id}")
    if response['recording']
      new(response['recording'])
    end
  end

  def destroy
    response = delete("/recordings/#{id}")
    return true if response
  end
end
