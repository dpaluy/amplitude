require 'faraday'

module Amplitude
  class Client
    ENDPOINT = 'https://api.amplitude.com'.freeze
    HEADERS = {
      'Content-Type' => 'application/json', 'Accept' => 'application/json'
    }.freeze

    attr_reader :key, :secret, :endpoint, :enabled

    def initialize(key: nil, secret: nil, endpoint: nil)
      @key      = key       || Amplitude.config.key
      @secret   = secret    || Amplitude.config.secret
      @endpoint = endpoint  || Amplitude.config.endpoint || ENDPOINT
      @enabled  = Amplitude.config.enabled.nil? ? true : Amplitude.config.enabled
      raise ArgumentError, 'Amplitude key or secret are missing' unless @secret && @key
    end

    def post(url, body = {}, basic_auth:)
      return unless enabled

      conn = connection(basic_auth)
      merged_body = basic_auth ? body : { api_key: key }.merge(body)
      conn.post(url) do |req|
        req.headers = HEADERS
        req.body    = merged_body
      end
    end

    def get(url, params = {}, basic_auth:)
      return unless enabled

      conn = connection(basic_auth)
      merged_params = basic_auth ? params : { api_key: key }.merge(params)
      conn.get(url) do |req|
        req.headers = HEADERS
        req.params  = merged_params
      end
    end

    private

    def connection(basic_auth)
      conn = Faraday.new(url: @endpoint)
      conn.basic_auth(key, secret) if basic_auth
      conn
    end
  end
end
