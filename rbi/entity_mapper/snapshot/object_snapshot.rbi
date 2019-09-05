# typed: strong

module EntityMapper
  module Snapshot
    class ObjectSnapshot < T::Struct
      const :object, T.untyped
      const :properties_map, T::Hash[Mapping::Property, T.untyped]
      const :relations_map, T::Hash[Mapping::Relation, T.untyped]
    end
  end
end
