# typed: true
# frozen_string_literal: true

require "zeitwerk"
require_relative "entity_mapper/zeitwerk_inflector"

loader = Zeitwerk::Loader.for_gem
loader.inflector = EntityMapper::ZeitwerkInflector.new(__FILE__)
loader.eager_load_exclusions.add File.join(__dir__, "entity_mapper/zeitwerk_inflector.rb")
loader.setup
loader.eager_load

module EntityMapper
  def self.map
    Mapping::Model.new.tap do |mapping|
      yield Mapping::DSL.new(mapping)
    end
  end
end
