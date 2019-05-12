# frozen_string_literal: true

require 'xcassetscop/linter_rule'

RSpec.describe XCAssetsCop::LinterRule, '#initialize' do
  describe 'with missing keys' do
    obj = {}
    it 'should raise an error listing the missing keys' do
      expect { XCAssetsCop::LinterRule.new(obj) }.to raise_error("Missing keys: 'paths', 'config'")
    end
  end

  describe 'with unexpected keys' do
    obj = { invalid_key: :a, hello: :b, paths: '', config: { file_extension: 'pdg' } }
    it 'should raise an error listing the unexpected keys' do
      expect { XCAssetsCop::LinterRule.new(obj) }.to raise_error("Unexpected keys: 'invalid_key', 'hello'")
    end
  end
end
