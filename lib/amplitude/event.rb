module Amplitude
  class Event
    VALID_KEYS = Amplitude.config.event_keys
    attr_accessor(*VALID_KEYS)

    def initialize(attributes = {})
      attributes.each do |k, v|
        send("#{k}=", v) if respond_to?("#{k}=")
      end
      timestamp!
      validate_arguments
    end

    def to_hash
      response = {}
      VALID_KEYS.each do |key|
        value = send(key)
        response[key] = value if value
      end
      response
    end
    alias to_h to_hash

    private

    def timestamp!
      self.time = (time || Time.now).to_i
    end

    def validate_arguments
      raise ArgumentError, 'Amplitude Event: user_id or device_id must be set' unless user_id || device_id
      raise ArgumentError, 'You must provide event_type' unless event_type
    end
  end
end
