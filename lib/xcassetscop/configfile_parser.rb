# frozen_string_literal: true

require 'yaml'
require_relative 'linter_rule'

module XCAssetsCop
  module ConfigfileParser
    def self.parse(file_path)
      rules = YAML.load_file file_path
      rules.map { |r| LinterRule.new(r) }
    end
  end
end
