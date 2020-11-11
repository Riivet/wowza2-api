RSpec.describe Wowza::Api::StreamTarget::Base do

  it "returns all stream tarets" do
    items = Wowza::Api::StreamTarget::Base.list
    puts items.inspect
    expect(Wowza::Api::VERSION).not_to be nil
  end
end
