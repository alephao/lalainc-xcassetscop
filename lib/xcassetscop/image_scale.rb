# frozen_string_literal: true

require_relative 'utility'

module XCAssetsCop
  module ImageScale
    AVAILABLE_VALUES = %i[
      single
      individual
      individual_and_single
    ].freeze

    def self.validate(value)
      Utility.validate_params(value, AVAILABLE_VALUES)
    end
  end
end
