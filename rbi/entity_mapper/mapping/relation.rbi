# typed: true

module EntityMapper
  module Mapping
    class Relation < Property
      sig { params(name: T.any(Symbol, String), persistence_name: T.any(Symbol, String), mapping: Mapping::Model, options: Hash).void }
      def initialize(name, persistence_name, mapping, options)
      end

      sig { returns(Mapping::Model) }
      def mapping; end

      sig { returns(T::Boolean) }
      def virtual?
      end

      sig { returns(T::Boolean) }
      def collection?
      end
    end
  end
end
