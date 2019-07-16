# frozen_string_literal: true

module EntityMapper
  module Snapshot
    class TakeSnapshot
      def call(object, mapping)
        ObjectSnapshot.new(
          object: object,
          properties_map: properties_map(object, mapping.properties),
          relations_map: relations_map(object, mapping.relations)
        )
      end

      def properties_map(object, properties)
        properties.each_with_object({}) do |property, hash|
          hash[property] = property.read_from(object)
        end
      end

      def relations_map(object, relations)
        relations.each_with_object({}) do |relation, hash|
          relation_value = relation.read_from(object)

          hash[relation] = relation.collection? ?
            relation_value.map { |relation_object| call(relation_object, relation.mapping) } :
            call(relation_value, relation.mapping)
        end
      end
    end
  end
end
