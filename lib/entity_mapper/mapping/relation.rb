# frozen_string_literal: true

module EntityMapper
  module Mapping
    class Relation < Property
      attr_reader :mapping, :peristence_name, :options

      def initialize(name, peristence_name, mapping, options)
        super(name, peristence_name, options)
        @mapping = mapping
        @options = options
      end

      def virtual?
        peristence_name.nil?
      end

      def collection?
        false
      end
    end
  end
end
