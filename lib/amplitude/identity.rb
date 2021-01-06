module Amplitude
  class Identity
    ANONYMOUS = 'anonymous'.freeze
    VALID_KEYS = %i[
      platform os_name os_version
      device_brand device_manufacturer device_model
      carrier
      country region city dma
      app_version language paying start_version
    ].freeze

    attr_reader :user_id, :device_id, :user_properties, :properties

    def initialize(user_id: nil, device_id: nil, user_properties: {})
      @user_id = user_id
      @device_id = device_id
      @user_properties = user_properties
      @properties = {}
    end

    def additional_properties(attr = {})
      @properties = properties.merge(attr.select_keys(VALID_KEYS))
    end

    def to_hash
      {
        user_id: user_identify,
        user_properties: user_properties,
        device_id: device_id
      }.merge(properties)
    end

    private

    def user_identify
      user_id.nil? && device_id.nil? ? ANONYMOUS : user_id
    end
  end
end
