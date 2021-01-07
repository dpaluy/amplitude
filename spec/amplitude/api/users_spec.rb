require 'spec_helper'

describe Amplitude::Api::Users do
  before :all do
    Amplitude.configure do |config|
      config.key    = 'mylogin'
      config.secret = 'secret'
    end
  end

  describe '#delete!' do
    let(:user_id) { '123' }
    let(:requester) { 'admin@company.com' }
    let(:response_body) do
      {
        'day' => '2020-01-01',
        'user_ids' => [
          {
            'user_id' => user_id,
            'requested_on_day' => Time.now.to_i,
            'requester' => requester
          }
        ],
        'status' => 'pending'
      }
    end
    let(:mocked_body) do
      {
        'ignore_invalid_id' => 'True',
        'requester' => requester,
        'user_ids' => [user_id]
      }
    end

    it 'sends tracking event' do
      stub_request(:post, 'https://api.amplitude.com/2/deletions/users')
        .to_return(status: 200, body: response_body.to_json)
      response = Amplitude::Api::Users.delete!(user_ids: [user_id], requester: requester)
      expect(response).to eq(response_body)
    end
  end
end
