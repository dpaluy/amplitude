require 'spec_helper'

describe Amplitude::Identity do
  let(:device_id) { 'iDevice12' }
  let(:user_id) { 'user_id' }
  let(:user_properties) do
    { foo: 'foo', baz: 'baz' }
  end

  context 'with user_id' do
    let(:expected_hash) do
      {
        user_id: user_id,
        user_properties: user_properties,
        device_id: nil
      }
    end

    subject { Amplitude::Identity.new(user_id: user_id, user_properties: user_properties) }

    it '#to_hash' do
      expect(subject.to_hash).to match(expected_hash)
    end
  end

  context 'without user_id' do
    context 'anonymous' do
      let(:unassigned_id) { 'anonymous' }
      let(:expected_hash) do
        {
          user_id: unassigned_id,
          user_properties: user_properties,
          device_id: nil
        }
      end
      subject { Amplitude::Identity.new(user_properties: user_properties) }

      it '#to_hash' do
        expect(subject.to_hash).to match(expected_hash)
      end
    end

    context 'with device_id' do
      let(:expected_hash) do
        {
          user_id: nil,
          user_properties: user_properties,
          device_id: device_id
        }
      end
      subject { Amplitude::Identity.new(device_id: device_id, user_properties: user_properties) }

      it '#to_hash' do
        expect(subject.to_hash).to match(expected_hash)
      end
    end

    context '#additional_properties' do
      subject { Amplitude::Identity.new(user_id: user_id, user_properties: user_properties) }
      it 'valid key' do
        subject.additional_properties(platform: 'OS13')
        expected_hash = {
          user_id: user_id,
          user_properties: user_properties,
          device_id: nil,
          platform: 'OS13'
        }
        expect(subject.to_hash).to match(expected_hash)
      end
    end
  end
end
