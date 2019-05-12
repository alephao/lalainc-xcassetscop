# frozen_string_literal: true

require_relative './config_options'

module XCAssetsCop
  class LinterRule
    attr_reader :paths, :config

    def initialize(obj)
      LinterRule.ensure_no_missing_keys obj
      LinterRule.ensure_all_keys_are_allowed obj
      _paths = obj.sdig(:paths).map { |path| File.expand_path(path) }
      @paths = Dir.glob(_paths)
      @config = ConfigOptions.new obj.sdig(:config)
    end

    def self.ensure_no_missing_keys(obj)
      obj_sym = obj.keys.map(&:to_sym)
      missing_keys = []
      missing_keys << :paths unless obj_sym.include? :paths
      missing_keys << :config unless obj_sym.include? :config
      raise StandardError, "Missing key#{'s' if missing_keys.size > 1}: #{missing_keys.map { |s| "'#{s}'" }.join(', ')}" if missing_keys.size.positive?
    end

    def self.ensure_all_keys_are_allowed(obj)
      diff = obj.keys.map(&:to_sym) - %i[paths config]
      raise StandardError, "Unexpected key#{'s' if diff.size > 1}: #{diff.map { |s| "'#{s}'" }.join(', ')}" if diff.size.positive?
    end
  end
end
