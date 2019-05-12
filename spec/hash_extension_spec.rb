# frozen_string_literal: true

require 'xcassetscop/hash_extension'

RSpec.describe Hash, '#sdig' do
  describe 'with symbol key' do
    subject = { my_key: 'hello' }
    it 'should work with string key' do
      expect(subject.sdig('my_key')).to eq 'hello'
    end
  end

  describe 'with string key' do
    subject = { 'my_key': 'hello' }
    it 'should work with symbol key' do
      expect(subject.sdig(:my_key)).to eq 'hello'
    end
  end
end
