# frozen_string_literal: true

module XCAssetsCop
  module Utility
    def self.validate_params(param, valid_params)
      return true if valid_params.include? param

      raise StandardError, "'#{param}' is not a valid parameter.\nValid parameters: #{valid_params.join(', ')}"
    end
  end
end
