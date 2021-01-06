require 'spec_helper'

describe Amplitude::Event do
  let(:device_id) { 'iDevice12' }
  let(:user_id) { 'user_id' }
  let(:event_type) { 'run_spec' }
  let(:user_properties) do
    { age: 25, gender: 'female' }
  end

  describe 'validate' do
    it 'raise error if identifier missing' do
      expect {
        Amplitude::Event.new(event_type: event_type)
      }.to raise_error(ArgumentError)
    end

    it 'raise error if event_type is missing' do
      expect {
        Amplitude::Event.new(user_id: user_id)
      }.to raise_error(ArgumentError)
    end

    it 'user_id and event' do
      expect {
        Amplitude::Event.new(user_id: user_id, event_type: event_type)
      }.not_to raise_error
    end

    it 'device_id and event' do
      expect {
        Amplitude::Event.new(device_id: device_id, event_type: event_type)
      }.not_to raise_error
    end
  end

  describe '#time' do
    it 'set current time' do
      travel_to Time.new(2021, 2, 1, 11, 15)
      event = Amplitude::Event.new(user_id: user_id, event_type: event_type)
      expect(event.time).to eq(1612199700)
      travel_back
    end

    it 'user preset time' do
      time = Time.new(2021, 1, 1, 11)
      event = Amplitude::Event.new(user_id: user_id, event_type: event_type, time: time)
      expect(event.time).to eq(1609520400)
    end
  end

  describe '#to_hash' do
    let(:event_json) do
      File.read(
        File.expand_path('../fixtures/event.json', File.dirname(__FILE__))
      ).strip
    end
    let(:event_hash) do
      JSON.parse(event_json)
    end

    it 'returns valid hash' do
      time = Time.at(event_hash['time'])
      attributes = event_hash.merge('time' => time)
      event = Amplitude::Event.new(attributes)
      expect(event.to_hash).to eq(event_hash)
    end
  end
end
