# typed: true
# frozen_string_literal: true

module EntityMapper
  module Snapshot
    class ObjectSnapshot
      def initialize(object:, properties_map:, relations_map:)
        @object = object
        @properties_map = properties_map
        @relations_map = relations_map
      end

      attr_reader :object, :properties_map, :relations_map
    end
  end
end
