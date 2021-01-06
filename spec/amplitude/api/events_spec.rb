require 'spec_helper'

describe Amplitude::Api::Events do
  before :all do
    Amplitude.configure do |config|
      config.key    = 'mylogin'
      config.secret = 'secret'
    end
  end

  let(:time) { Time.new(2020, 1, 1, 10) }
  let(:event_params) do
    {
      user_id: 123,
      event_type: 'click button',
      time: time
    }
  end

  let(:response_body) do
    {
      'code' => 200,
      'events_ingested' => 50,
      'payload_size_bytes' => 50,
      'server_upload_time' => 1396381378123
    }
  end

  it 'sends tracking event' do
    stub_request(:post, 'https://api.amplitude.com/2/httpapi')
      .to_return(status: 200, body: response_body.to_json)
    response = Amplitude::Api::Events.track!(event_params)
    expect(response).to eq(response_body)
  end
end
