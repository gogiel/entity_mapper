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

      def remove_strategy(strategy)
        mapping.remove_strategy = strategy
      end

      def property(name, persistence_name = nil, **options)
        mapping.add_property Property.new(name, persistence_name || name, options)
      end

      # rubocop:disable Naming/PredicateName
      def has_one(relation_name, persistence_name:, **options)
        inner_mapping = Model.new.tap do |mapping|
          yield DSL.new(mapping)
        end
        mapping.add_relation HasOneRelation.new(relation_name, persistence_name, inner_mapping, options)
      end

      def has_one_virtual(relation_name, **options)
        inner_mapping = Model.new.tap do |mapping|
          yield DSL.new(mapping)
        end
        mapping.add_relation HasOneVirtualRelation.new(relation_name, inner_mapping, options)
      end

      def has_many(relation_name, persistence_name:, **options)
        inner_mapping = Model.new.tap do |mapping|
          yield DSL.new(mapping)
        end
        mapping.add_relation HasManyRelation.new(relation_name, persistence_name, inner_mapping, options)
      end
      # rubocop:enable Naming/PredicateName
    end
  end
end
