require_relative './xcassets_cop'
require_relative './xcassets_cop_linter'

XCAssetsCop::Linter.lint_files ARGV
