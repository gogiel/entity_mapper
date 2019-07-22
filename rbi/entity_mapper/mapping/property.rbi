# typed: true

module EntityMapper
  module Mapping
    class Property
      sig { returns(T.any(Symbol, String)) }
      def persistence_name; end

      sig { returns(T.any(Symbol, String)) }
      def name; end

      sig { returns(Hash) }
      def options; end

      sig { params(name: T.any(Symbol, String), persistence_name: T.any(Symbol, String), options: Hash).void }
      def initialize(name, persistence_name, options)
      end
    end
  end
end
