# frozen_string_literal: true

module EntityMapper
  module Snapshot
    ObjectSnapshot = Struct.new(:object, :properties_map, :relations_map)
  end
end
