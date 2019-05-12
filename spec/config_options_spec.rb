# frozen_string_literal: true

require 'xcassetscop/config_options'

RSpec.describe XCAssetsCop::ConfigOptions, '#initialize' do
  describe 'with invalid key' do
    it 'should raise an error with invalid key' do
      config = { some_invalid_key: 'hello' }
      expect { XCAssetsCop::ConfigOptions.new config }.to raise_error("Unexpected key: 'some_invalid_key'")
    end
  end

  describe 'with multiple invalid keys' do
    it 'should raise an exception listing the invalid keys' do
      config = { some_invalid_key: 'hello', another_invalid_key: 'olar' }
      expect { XCAssetsCop::ConfigOptions.new config }.to raise_error("Unexpected keys: 'some_invalid_key', 'another_invalid_key'")
    end
  end

  describe 'with valid keys' do
    it 'should succeed' do
      config = { template_rendering_intent: :default }
      subject = XCAssetsCop::ConfigOptions.new config
      expect(subject.template_rendering_intent).to eq :default
    end
  end
end
