require 'logger'
require 'yaml'

module Amplitude
  class Config
    attr_accessor :key, :secret, :endpoint, :enabled

    def logger
      @logger ||= Logger.new(STDERR)
    end

    def event_keys
      @event_keys ||= YAML.load_file('lib/config/event_keys.yml')
    end
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end
end
