# frozen_string_literal: true

require_relative 'utility'

module XCAssetsCop
  module TemplateRenderingIntent
    AVAILABLE_VALUES = %i[
      original
      template
      default
    ].freeze

    def self.validate(value)
      Utility.validate_params(value, AVAILABLE_VALUES)
    end
  end
end
