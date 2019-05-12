# frozen_string_literal: true

require_relative 'configfile_parser'

module XCAssetsCop
  module CLI
    def self.run(args)
      configfile_path = File.expand_path args[0]
      unless File.file? configfile_path
        puts "Can't find file on path: #{configfile_path}"
        return
      end
      puts "Using config file at #{configfile_path}"

      rules = ConfigfileParser.parse configfile_path
      amount_of_files = rules.reduce(0) { |acc, rule| rule.paths.size + acc }
      errors = Linter.lint_files rules

      puts "#{rules.size} rules found"
      puts "#{amount_of_files} files checked"
      if errors.size.positive?
        puts "Found #{errors.size} offenses:"
        puts errors
      else
        puts 'No errors found'
      end
    end
  end
end
