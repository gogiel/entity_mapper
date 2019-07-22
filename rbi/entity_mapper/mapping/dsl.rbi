# typed: true

module EntityMapper
  module Mapping
    class DSL
      sig { params(mapping: Model).void }
      def initialize(mapping)
      end

      sig { returns(Model) }
      def mapping; end

      sig { params(klass: Class).void }
      def model(klass)
      end

      sig { params(strategy: Symbol).void }
      def remove_strategy(strategy)
      end

      sig { params(name: T.any(Symbol, String), persistence_name: T.nilable(T.any(Symbol, String)), options: T.untyped).void }
      def property(name, persistence_name = nil, **options)
      end

      sig { params(relation_name: T.any(Symbol, String), persistence_name: T.any(Symbol, String), options: T.untyped, block: T.proc.params(arg0: DSL).void).void }
      def has_one(relation_name, persistence_name:, **options, &block)
      end

      sig { params(relation_name: T.any(Symbol, String), options: Hash, block: T.proc.params(arg0: DSL).void).void }
      def has_one_virtual(relation_name, **options, &block)
      end

      sig { params(relation_name: T.any(Symbol, String), persistence_name: T.any(Symbol, String), options: T.untyped, block: T.proc.params(arg0: DSL).void).void }
      def has_many(relation_name, persistence_name:, **options, &block)
      end
    end
  end
end
