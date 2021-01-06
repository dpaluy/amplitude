module Amplitude
  class ApiConnection
    attr_reader :client

    def initialize
      @client = Amplitude::Client.new
    end

    protected

    def handle_response(response)
      case response.status
      when 200
        JSON.parse response.body
      when 400
        raise InvalidRequestError, 'Amplitude Bad request'
      when 413
        raise InvalidRequestError, 'Amplitude Too many events in request'
      when 429
        raise InvalidRequestError, 'Amplitude Too many requests for a device'
      when 503
        raise InvalidRequestError, 'Amplitude Service unavailable'
      else
        raise InvalidRequestError, "Amplitude Server Error <#{response.status}>"
      end
    end
  end
end
