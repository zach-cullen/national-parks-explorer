require_relative 'lib/national_parks_explorer/version'

Gem::Specification.new do |spec|
  spec.name          = "national_parks_explorer"
  spec.version       = NationalParksExplorer::VERSION
  spec.authors       = ["Zach Cullen"]
  spec.email         = ["zacullen@gmail.com"]

  spec.summary       = %q{A CLI that helps users find information about National Parks.}
  spec.description   = %q{A CLI that helps users find information about National Parks.}
  #spec.homepage      = "https://github.com/zach-cullen/national-parks-explorer"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = ""
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rest-client", ">=0"
  spec.add_dependency "json", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
  spec.add_dependency "rainbow"
end
