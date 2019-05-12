# frozen_string_literal: true

require 'xcassetscop/template_rendering_intent'

RSpec.describe XCAssetsCop::TemplateRenderingIntent, '#validate' do
  context 'with invalid param' do
    it 'should raise an exception' do
      expect { XCAssetsCop::TemplateRenderingIntent.validate('invalid') }.to raise_error("'invalid' is not a valid parameter.\nValid parameters: original, template, default")
    end
  end
end
