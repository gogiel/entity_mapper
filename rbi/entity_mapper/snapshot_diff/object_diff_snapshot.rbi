# typed: true

module EntityMapper
  module SnapshotDiff
    class ObjectDiffSnapshot
      sig { params(object: T.untyped, properties_map: T::Hash[Mapping::Property, T.untyped], relations_map: T::Hash[Mapping::Relation, T.untyped], state: Symbol).void }
      def initialize(object:, properties_map:, relations_map:, state:)
      end

      sig { returns(T::Hash[Mapping::Property, T.untyped]) }
      def properties_map; end

      sig { returns(T::Hash[Mapping::Relation, T.untyped]) }
      def relations_map; end

      sig { returns(Symbol) }
      def state; end

      sig { returns(T::Boolean) }
      def new?
      end

      sig { returns(T::Boolean) }
      def changed?
      end

      sig { returns(T::Boolean) }
      def unchanged?
      end

      sig { returns(T::Boolean) }
      def removed?
      end
    end
  end
end
