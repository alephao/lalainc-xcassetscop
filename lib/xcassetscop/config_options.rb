# frozen_string_literal: true

require_relative './hash_extension'
require_relative './template_rendering_intent'
require_relative './image_scale'

module XCAssetsCop
  class ConfigOptions
    attr_reader :file_extension, :image_scale, :same_file_and_asset_name, :template_rendering_intent,
                :preserves_vector_representation

    ALLOWED_KEYS = %i[
      file_extension
      image_scale
      same_file_and_asset_name
      template_rendering_intent
      preserves_vector_representation
    ].freeze

    def initialize(obj)
      ensure_all_keys_are_allowed obj
      @file_extension = obj.sdig('file_extension')
      @image_scale = obj.sdig('image_scale')
      @same_file_and_asset_name = obj.sdig('same_file_and_asset_name')
      @template_rendering_intent = obj.sdig('template_rendering_intent')
      @preserves_vector_representation = obj.sdig('preserves_vector_representation')
    end

    private

    def ensure_all_keys_are_allowed(obj)
      diff = obj.keys.map(&:to_sym) - ALLOWED_KEYS
      raise StandardError, "Unexpected key#{'s' if diff.size > 1}: #{diff.map { |s| "'#{s}'" }.join(', ')}" if diff.size.positive?
    end

    def validate
      TemplateRenderingIntent.validate @template_rendering_intent if @template_rendering_intent
      ImageScale.validate @image_scale if @template_rendering_intent
    end
  end
end
