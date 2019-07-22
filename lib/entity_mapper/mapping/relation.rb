# typed: true
# frozen_string_literal: true

module EntityMapper
  module Mapping
    class Relation < Property
      attr_reader :mapping, :persistence_name

      def initialize(name, persistence_name, mapping, options)
        super(name, persistence_name, options)
        @mapping = mapping
      end

      def virtual?
        false
      end

      def collection?
        false
      end
    end
  end
end
