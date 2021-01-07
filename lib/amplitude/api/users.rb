module Amplitude
  module Api
    class Users < Base
      class << self
        def delete!(user_ids: nil, amplitude_ids: nil, requester: nil)
          body = {
            user_ids: user_ids,
            amplitude_ids: amplitude_ids,
            requester: requester,
            ignore_invalid_id: 'True'
          }.compact
          new.request('post', '2/deletions/users', body, basic_auth: true)
        end
      end
    end
  end
end
