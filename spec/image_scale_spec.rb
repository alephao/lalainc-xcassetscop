# frozen_string_literal: true

require 'xcassetscop/image_scale'

RSpec.describe XCAssetsCop::ImageScale, '#validate' do
  context 'with invalid param' do
    it 'should raise an exception' do
      expect { XCAssetsCop::ImageScale.validate('invalid') }.to raise_error("'invalid' is not a valid parameter.\nValid parameters: single, individual, individual_and_single")
    end
  end
end
