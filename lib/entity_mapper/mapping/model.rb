# frozen_string_literal: true

require "set"

module EntityMapper
  module Mapping
    class Model
      attr_accessor :model_class
      attr_reader :properties, :relations, :remove_strategy

      def initialize
        @properties = Set.new
        @relations = Set.new
      end

      attr_writer :remove_strategy

      def add_relation(relation)
        relations << relation
      end

      def add_property(property)
        properties << property
      end

      def relation_by_name(name)
        relations.find { |r| r.name.to_s.eql? name.to_s }
      end

      def property_by_name(name)
        properties.find { |p| p.name.to_s.eql? name.to_s }
      end
    end
  end
end
