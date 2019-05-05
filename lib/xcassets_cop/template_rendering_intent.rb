module XCAssetsCop
  module TemplateRenderingIntent
    ORIGINAL = :original
    TEMPLATE = :template
    DEFAULT = :default

    def self.available_values
      [ORIGINAL, TEMPLATE, DEFAULT]
    end
  end
end
