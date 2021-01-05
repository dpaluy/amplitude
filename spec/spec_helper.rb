require 'simplecov'
require 'codeclimate-test-reporter'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'amplitude'
require 'byebug'
require 'webmock/rspec'
require 'timecop'
require 'active_support/core_ext/hash'

if ENV['COVERAGE']
  SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter[
        SimpleCov::Formatter::HTMLFormatter,
        CodeClimate::TestReporter::Formatter
      ]
  end
  WebMock.disable_net_connect!(allow: 'codeclimate.com')
  CodeClimate::TestReporter.start
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
end
