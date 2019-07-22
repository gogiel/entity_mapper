# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    class Read
      def self.call(mapping, root)
        new.call(mapping, root)
      end

      def call(mapping, root)
        @ar_map = ArMap.new
        [read(mapping, root), @ar_map]
      end

      private

      def read(mapping, ar_model)
        object = mapping.model_class.allocate

        read_properties(mapping.properties, object, ar_model)
        read_relations(mapping.relations, object, ar_model)

        @ar_map[object] = ar_model

        object
      end

      def read_properties(properties, object, ar_model)
        properties.each do |property|
          property.write_to(object, ar_model.public_send(property.persistence_name))
        end
      end

      def read_relations(relations, object, ar_model)
        relations.each do |relation|
          result = if !relation.virtual?
            read_ar_relations(ar_model, relation)
          else
            read(relation.mapping, ar_model)
          end

          relation.write_to(object, result)
        end
      end

      def read_ar_relations(ar_model, relation)
        if relation.collection?
          ar_model.public_send(relation.persistence_name).map do |ar_object|
            read(relation.mapping, ar_object)
          end
        else
          ar_object = ar_model.public_send(relation.persistence_name)
          read(relation.mapping, ar_object) if ar_object
        end
      end
    end
  end
end
