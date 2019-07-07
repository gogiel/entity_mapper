# frozen_string_literal: true

require "zeitwerk"
require_relative "entity_mapper/zeitwerk_inflector"

loader = Zeitwerk::Loader.for_gem
loader.inflector = EntityMapper::ZeitwerkInfelctor.new(__FILE__)
loader.setup

module EntityMapper
  def self.map
    Mapping::Model.new.tap do |mapping|
      yield Mapping::DSL.new(mapping)
    end
  end
end
