# typed: true
# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    class MappingsRegistry
      def initialize
        @mappings = {}
      end

      def register(active_record_class, map)
        @mappings[active_record_class] = map
      end

      def read(active_record_object, context: nil)
        map = find_map_for_record(active_record_object)

        with_context(context) do |mapping_context|
          mapping_context.read(map, active_record_object).tap do |object|
            yield object if block_given?
          end
        end
      end

      def create(entity, context: nil)
        active_record_class, mapping = find_map_for_entity(entity)
        with_context(context) do |mapping_context|
          mapping_context.create(mapping, entity, active_record_class).tap do |object|
            yield object if block_given?
          end
        end
      end

      private

      def with_context(context, &block)
        if context
          yield context
        else
          Transaction.call(&block)
        end
      end

      def find_map_for_record(active_record_object)
        map = @mappings[active_record_object.class]
        unless map
          _, map = @mappings.find do |active_record_class, _map|
            active_record_object.is_a?(active_record_class)
          end
        end
        raise("#{active_record_object.class} class record not registered.") unless map

        map
      end

      def find_map_for_entity(entity)
        results = @mappings.find_all do |_active_record_class, mapping|
          mapping.model_class.equal?(entity.class)
        end
        raise "Ambiguous mapping for #{entity.class}" if results.length > 1
        raise "#{entity.class} entity not registered" if results.empty?

        results.first
      end
    end
  end
end
