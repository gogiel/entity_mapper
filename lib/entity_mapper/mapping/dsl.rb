# frozen_string_literal: true

module EntityMapper
  module Mapping
    class DSL
      def initialize(mapping)
        @mapping = mapping
      end

      attr_reader :mapping

      def model(klass)
        mapping.model_class = klass
      end

      def property(name, peristence_name = nil, **options)
        mapping.add_property Property.new(name, peristence_name || name, options)
      end

      # rubocop:disable Naming/PredicateName
      def has_one(relation_name, peristence_name:, **options)
        inner_mapping = Mapping::Model.new.tap do |mapping|
          yield DSL.new(mapping)
        end
        mapping.add_relation HasOneRelation.new(relation_name, peristence_name, inner_mapping, options)
      end

      def has_many(relation_name, peristence_name:, **options)
        inner_mapping = Mapping::Model.new.tap do |mapping|
          yield DSL.new(mapping)
        end
        mapping.add_relation HasManyRelation.new(relation_name, peristence_name, inner_mapping, options)
      end
      # rubocop:enable Naming/PredicateName
    end
  end
end
