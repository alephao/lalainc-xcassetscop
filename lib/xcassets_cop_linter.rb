require 'json'
require_relative './xcassets_cop'
require_relative './template_rendering_intent'
require_relative './image_scale'

module XCAssetsCop
  module Linter
    def self.get_file_name(contents_json)
      contents_json&.dig('images')&.first&.dig('filename')
    end

    def self.file_name_matches_asset_name(contents_json, file_path)
      asset_name = (file_path.split('/').select do |str| str.include? ".imageset" end).first.split('.').first
      file_name = get_file_name(contents_json).split('.').first
      return true if file_name == asset_name
      raise StandardError, "Expected asset name and file name to be the same, got:\nAsset name: #{asset_name}\nFile name: #{file_name}"
    end

    def self.validate_image_scale(contents_json, expected)
      validate_params expected, ImageScale.available_values
      case contents_json&.dig('images')&.size
      when 1
        image_scale = ImageScale::SINGLE
      when 3
        image_scale = ImageScale::INDIVIDUAL
      when 4
        image_scale = ImageScale::INDIVIDUAL_AND_SINGLE
      else
        raise StandardError, "Couldn't figure out the image scale"
      end
      return true if image_scale == expected
      file_name = get_file_name contents_json
      raise StandardError, "Expected #{file_name} scale to be '#{expected}', got '#{image_scale}' instead"
    end

    def self.validate_template_rendering_intent(contents_json, expected)
      validate_params expected, TemplateRenderingIntent.available_values
      template_rendering_intent = contents_json&.dig('properties')&.dig('template-rendering-intent') || TemplateRenderingIntent::DEFAULT
      return true if template_rendering_intent == expected
      file_name = get_file_name contents_json
      raise StandardError, "Expected #{file_name} to be rendered as '#{expected}', got '#{template_rendering_intent}' instead"
    end

    def self.validate_params(param, valid_params)
      return true if valid_params.include? param
      raise StandardError, "'#{param}' is not a valid parameter.\nValid parameters: #{valid_params.join(', ')}"
    end

    def self.validate_file_extension(contents_json, expected)
      file_name = get_file_name(contents_json)
      file_extension = file_name.split('.').last
      return true if expected == file_extension
      raise StandardError, "Expected #{file_name} type to be #{expected}, got #{file_extension} instead"
    end

    def self.lint_file(file_path, config = nil)
      file = File.read file_path
      contents_json = JSON.parse file

      template_rendering_intent = config&.dig('template_rendering_intent')
      image_scale = config&.dig('image_scale')
      same_file_and_asset_name = config&.dig('same_file_and_asset_name') || false
      file_extension = config&.dig('file_extension')

      errors = []

      if template_rendering_intent
        begin
          validate_template_rendering_intent contents_json, template_rendering_intent
        rescue StandardError => e
          errors << e.message
        end
      end

      if image_scale
        begin
          validate_image_scale contents_json, image_scale
        rescue StandardError => e
          errors << e.message
        end
      end

      if same_file_and_asset_name
        begin
          file_name_matches_asset_name contents_json, file_path
        rescue StandardError => e
          errors << e.message
        end
      end

      if file_extension
        begin
          validate_file_extension contents_json, file_extension
        rescue StandardError => e
          errors << e.message
        end
      end

      errors
    end

    def self.lint_files(paths)
      config = {'template_rendering_intent' => :template, 'image_scale' => :single, 'same_file_and_asset_name' => true, 'file_extension' => 'jpg'}
      errors = []
      for file_path in paths
        errors += lint_file(file_path, config)
      end
      puts errors
    end
  end
end
