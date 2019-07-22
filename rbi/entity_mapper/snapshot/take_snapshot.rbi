# typed: true

module EntityMapper
  module Snapshot
    class TakeSnapshot
      sig { params(object: T.untyped, mapping: Mapping::Model).returns(ObjectSnapshot) }
      def call(object, mapping)
      end

      sig { params(object: T.untyped, properties: T::Array[Mapping::Property]).returns(T::Hash[Mapping::Property, T.untyped]) }
      def properties_map(object, properties)
      end

      sig { params(object: T.untyped, relations: T::Array[Mapping::Relation]).returns(T::Hash[Mapping::Relation, T.untyped]) }
      def relations_map(object, relations)
      end
    end
  end
end
