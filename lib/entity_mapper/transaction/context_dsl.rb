# typed: true
# frozen_string_literal: true

module EntityMapper
  class Transaction
    class ContextDSL
      def initialize(context)
        @context = context
      end

      def read(mapping, persisted_object)
        @context.read(mapping, persisted_object)
      end

      def create(mapping, entity, persistence_reference)
        @context.create(mapping, entity, persistence_reference)
      end
    end
  end
end
