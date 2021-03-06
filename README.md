# Amplitude gem

This is a simple Ruby wrapper to [Amplitude](https://developers.amplitude.com/docs/http-api-v2) API v2

## Usage

`gem 'amplitude'`

You just need to provide the authentication details in you configuration, and you're set. For example, in Rails that would go into config/initializers/amplitude.rb:

```
Amplitude.configure do |config|
  config.key    = 'mylogin'
  config.secret = 'secret'
end
```

### Event Tracking

See the list of a arguments for details: https://developers.amplitude.com/docs/http-api-v2#keys-for-the-event-argument

## Contributing to amplitude

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2021 dpaluy. See
LICENSE.txt for further details.
