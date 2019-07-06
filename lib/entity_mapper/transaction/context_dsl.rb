module EntityMapper
  class Transaction
    class ContextDSL
      def initialize(context)
        @context = context
      end

      def read(persisted_object)
        @context.read(persisted_object)
      end

      def create(entity, persistence_reference)
        @context.create(entity, persistence_reference)
      end
    end
  end
end
