# typed: true
# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    class Read
      def self.call(mapping, root, preload: true)
        new.call(mapping, root, preload: preload)
      end

      def call(mapping, root, preload:)
        @ar_map = ArMap.new
        preload_relations(mapping, root) if preload
        [read(mapping, root), @ar_map]
      end

      private

      def read(mapping, ar_model)
        object = mapping.allocate_model(ar_model)

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

      def preload_relations(mapping, root)
        relations_to_preload = RelationsPreload.call(mapping)
        if Rails.version >= "7"
          ::ActiveRecord::Associations::Preloader.new(records: [root], associations: relations_to_preload).call
        else
          ::ActiveRecord::Associations::Preloader.new.preload(root, relations_to_preload)
        end
      end
    end
  end
end
