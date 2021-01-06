module Amplitude
  module Api
    class Events < Base
      class << self
        def track!(options)
          event = Amplitude::Event.new(options)
          new.request('post', '2/httpapi', event.to_h, basic_auth: false)
        end
      end
    end
  end
end
