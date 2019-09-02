# typed: false
# frozen_string_literal: true

require "bundler/setup"
require "entity_mapper"
require "combustion"

Combustion.initialize! :active_record do
  # Prevent deprecation message
  config.active_record.sqlite3.represent_boolean_as_integer = true
end

require "rspec/rails"

Zeitwerk::Loader.eager_load_all

RSpec.configure do |config|
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.use_transactional_fixtures = true
end

require_relative "support/shared_examples"
require_relative "support/active_record/queries_count"
