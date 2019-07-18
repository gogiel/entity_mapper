# frozen_string_literal: true

# TMP in propgress

module EntityMapper
  module ActiveRecord
    class Update
      # @param ar_map [EntityMapper::ArMap]
      def initialize(ar_map)
        @ar_map = ar_map
      end

      # @param mapping [EntityMapper::Mapping]
      # @param snapshot_diff [EntityMapper::ObjectDiffSnapshot]
      # @param ar_object [ActiveRecord::Base]
      def update(mapping, snapshot_diff, ar_object)
        map_properties(mapping.properties, snapshot_diff.object, ar_object)
        map_relations(mapping.relations, snapshot_diff, ar_object)

        if snapshot_diff.removed?
          RemoveStrategy.find(mapping.remove_strategy).call(ar_object)
        else
          ar_object.tap(&:save!)
        end
      end

      private

      def map_properties(properties, object, ar_object)
        properties.each do |property|
          ar_object.public_send("#{property.persistence_name}=", property.read_from(object))
        end
      end

      def map_relations(relations, snapshot_diff, parent_ar_object)
        relations.each do |relation|
          relation_snapshot = snapshot_diff.relations_map.fetch(relation)

          if relation.collection?
            update_collection_relation(relation, relation_snapshot, parent_ar_object)
          else
            update_single_item(relation, relation_snapshot, parent_ar_object)
          end
        end
      end

      def build(relation, parent_ar_object, relation_item_diff_snapshot)
        if relation.virtual?
          parent_ar_object
        else
          relation.options.fetch(:build_strategy, DefaultBuildStrategy).
            call(relation, parent_ar_object, relation_item_diff_snapshot)
        end
      end

      def update_collection_relation(relation, relation_snapshot, parent_ar_object)
        relation_snapshot.each do |relation_item_diff_snapshot|
          update_single_item(relation, relation_item_diff_snapshot, parent_ar_object)
        end
      end

      def update_single_item(relation, relation_snapshot, parent_ar_object)
        ar_object = if relation_snapshot.new?
          build(relation, parent_ar_object, relation_snapshot)
        else
          @ar_map.ar_object(relation_snapshot.object)
        end

        update(relation.mapping, relation_snapshot, ar_object) if ar_object
      end
    end
  end
end
