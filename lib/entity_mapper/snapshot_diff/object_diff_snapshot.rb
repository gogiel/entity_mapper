# frozen_string_literal: true

module EntityMapper
  module SnapshotDiff
    class ObjectDiffSnapshot
      def initialize(object:, properties_map:, relations_map:, state:)
        @object = object
        @properties_map = properties_map
        @relations_map = relations_map
        @state = state
      end

      attr_reader :object, :properties_map, :relations_map

      def new?
        @state.equal? :new
      end

      def changed?
        @state.equal? :changed
      end

      def unchanged?
        @state.equal? :unchanged
      end

      def removed?
        @state.equal? :removed
      end
    end
  end
end
