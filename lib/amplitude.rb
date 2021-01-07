require 'extensions/hash'

require 'amplitude/api/base'
require 'amplitude/api/events'
require 'amplitude/api/users'
require 'amplitude/config'
require 'amplitude/client'
require 'amplitude/event'
require 'amplitude/invalid_request_error'
require 'amplitude/engine' if defined?(Rails)

module Amplitude
  VERSION = File.read(File.expand_path('../../VERSION', __FILE__)).strip.freeze

  def self.logger
    config.logger
  end
end
