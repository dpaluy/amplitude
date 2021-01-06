require 'spec_helper'

describe Amplitude::Client do
  let(:service) { 'service1' }
  let(:params)  do
    { id: '1' }
  end

  let(:body) do
    { key1: 'value1', key2: 'value2' }
  end

  describe 'Disable connection' do
    before do
      Amplitude.configure { |c| c.enabled = false }
    end

    after do
      Amplitude.configure { |c| c.enabled = true }
    end

    let(:client) { Amplitude::Client.new(key: 'token', secret: 'pass') }

    it 'skip post' do
      response = client.post(service, body, basic_auth: false)
      expect(response).to be_nil
    end

    it 'skip get' do
      response = client.get(service, params, basic_auth: false)
      expect(response).to be_nil
    end
  end

  describe 'Valid Request' do
    let(:client) { Amplitude::Client.new(key: 'token', secret: 'pass', endpoint: 'http://localhost:8088/mock') }

    let(:api) do
      { api_key: 'token' }
    end

    context 'without basic auth' do
      it '#post' do
        blk = lambda do |req|
          expect(req.body).to match(api.merge(body))
        end
        stub_request(:post, "http://localhost:8088/mock/#{service}").with(&blk)
          .to_return(status: 200, body: '{"id": "123456"}')

        response = client.post(service, body, basic_auth: false)
        expect(response.status).to eql(200)
      end

      it '#get' do
        path = [service, api.merge(params).to_query].join('?')
        stub_request(:get, "http://localhost:8088/mock/#{path}")
          .to_return(status: 200, body: body.to_json)
        response = client.get(service, params, basic_auth: false)
        expect(response.status).to eql(200)
      end
    end

    context 'with basic auth' do
      it '#post' do
        blk = lambda do |req|
          expect(req.body).to match(body)
        end
        stub_request(:post, "http://localhost:8088/mock/#{service}").with(&blk)
          .to_return(status: 200, body: '{"id": "123456"}')

        response = client.post(service, body, basic_auth: true)
        expect(response.status).to eql(200)
      end

      it '#get' do
        path = [service, params.to_query].join('?')
        stub_request(:get, "http://localhost:8088/mock/#{path}")
          .to_return(status: 200, body: body.to_json)
        response = client.get(service, params, basic_auth: true)
        expect(response.status).to eql(200)
      end
    end
  end

  describe 'Configuration' do
    it 'requires token and secret' do
      expect { Amplitude::Client.new }.to raise_error(ArgumentError)
    end

    describe 'preset' do
      before do
        Amplitude.configure do |config|
          config.key      = 'mylogin'
          config.secret   = 'mypassword'
          config.endpoint = 'https://google.com'
        end
      end

      after do
        Amplitude.configure do |config|
          config.key      = nil
          config.secret   = nil
          config.endpoint = Amplitude::Client::ENDPOINT
        end
      end

      it 'configures the client' do
        Amplitude.configure do |config|
          config.key      = 'mylogin'
          config.secret   = 'mypassword'
          config.endpoint = 'https://google.com'
        end
        client = Amplitude::Client.new
        expect(client.key).to eq('mylogin')
        expect(client.secret).to eq('mypassword')
        expect(client.endpoint).to eq('https://google.com')
      end
    end
  end
end
