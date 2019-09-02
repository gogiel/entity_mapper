# typed: true
# frozen_string_literal: true

module EntityMapper
  class ContextDSL
    def initialize(context)
      @context = context
    end

    def read(mapping, persisted_object, options = {})
      @context.read(mapping, persisted_object, options)
    end

    def create(mapping, entity, persistence_reference)
      @context.create(mapping, entity, persistence_reference)
    end
  end
end
