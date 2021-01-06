module Amplitude
  module Api
    class Base
      attr_reader :client

      def initialize
        @client = Amplitude::Client.new
      end

      def request(kind, *args)
        response = client.send(kind, *args)
        handle_response(response)
      end

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
end
