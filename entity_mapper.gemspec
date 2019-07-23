# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "entity_mapper/version"

Gem::Specification.new do |spec|
  spec.name          = "entity_mapper"
  spec.version       = EntityMapper::VERSION
  spec.authors       = ["Jan Jędrychowski"]
  spec.email         = ["jan@jedrychowski.org"]

  spec.summary       = "Map persisted data to and from POROs"
  spec.description   = "Map persisted data to and from POROs"
  spec.homepage      = "https://github.com/gogiel/entity_mapper"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z -- lib/ rbi/`.split("\x0")
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "zeitwerk", "~> 2.1"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "combustion", "~> 1.1"
  spec.add_development_dependency "rails", "~> 5.2.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rubocop", "~> 0.72.0"
  spec.add_development_dependency "sorbet", "0.4.4485"
  spec.add_development_dependency "sqlite3"
end
