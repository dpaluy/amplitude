module Amplitude
  class Identify < ApiConnection
    URL = 'identify'.freeze

    def identify!(identity)
      client
    end
  end
end
