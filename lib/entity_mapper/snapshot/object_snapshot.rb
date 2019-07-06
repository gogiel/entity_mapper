module EntityMapper
  module Snapshot
    ObjectSnapshot = Struct.new(:object, :properties_map, :relations_map)
  end
end
