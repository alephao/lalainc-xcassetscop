# frozen_string_literal: true

module XCAssetsCop
  class Runner
    def initialize(options)
      @options = options
      @errors = []
    end

    def run(paths)
      list_files(paths)
    end

    private

    def list_files(paths)
      paths.each do |path|
        puts path
      end
    end
  end
end
