# frozen_string_literal: true

# TMP in propgress

module EntityMapper
  module ActiveRecord
    class Update
      # @param mapping [EntityMapper::Mapping]
      # @param snapshot_diff [EntityMapper::ObjectDiffSnapshot]
      # @param ar_root [ActiveRecord::Base]
      # @param ar_map [EntityMapper::ArMap]
      def self.call(mapping, snapshot_diff, ar_root, ar_map)
        new(ar_map).call(mapping, snapshot_diff, ar_root)
      end

      def initialize(ar_map)
        @ar_map = ar_map
      end

      def call(mapping, snapshot_diff, ar_root)
        update(mapping, snapshot_diff, ar_root)
      end

      private

      def update(mapping, snapshot_diff, ar_object)
        if snapshot_diff.removed? # TODO: - check if is virtual
          remove_strategy = RemoveStrategy.find(mapping.remove_strategy)
          if remove_strategy.update_nested?
            map_properties(mapping.properties, snapshot_diff.object, ar_object)
            map_relations(mapping.relations, snapshot_diff, ar_object)
          end
          remove_strategy.call(ar_object)
        else
          map_properties(mapping.properties, snapshot_diff.object, ar_object)
          map_relations(mapping.relations, snapshot_diff, ar_object)
          ar_object.tap(&:save!)
        end
      end

      def map_properties(properties, object, ar_object)
        properties.each do |property|
          ar_object.send("#{property.persistence_name}=", property.read_from(object))
        end
      end

      def map_relations(relations, snapshot_diff, parent_ar_object)
        relations.each do |relation|
          relation_snapshot = snapshot_diff.relations_map[relation]

          if relation.virtual?
            update_virtual_relation(relation, relation_snapshot, parent_ar_object)
          elsif relation.collection?
            update_collection_relation(relation, relation_snapshot, parent_ar_object)
          else
            update_single_relation(relation, relation_snapshot, parent_ar_object)
          end
        end
      end

      def build(relation, parent_ar_object, relation_item_diff_snapshot)
        relation.options.fetch(:build_strategy, ActiveRecord::DefaultBuildStrategy).
          call(relation, parent_ar_object, relation_item_diff_snapshot)
      end

      def update_virtual_relation(relation, relation_snapshot, parent_ar_object)
        if relation_snapshot.new?
          # TODO: support STI/polymporphism
          update(relation.mapping, relation_snapshot, parent_ar_object)
        elsif relation_snapshot.removed?
          # TODO: ??
        else
          update(relation.mapping, relation_snapshot, parent_ar_object)
        end
      end

      def update_collection_relation(relation, relation_snapshot, parent_ar_object)
        relation_snapshot.each do |relation_item_diff_snapshot|
          if relation_item_diff_snapshot.new?
            # TODO: support STI/polymporphism
            ar_object = build(relation, parent_ar_object, relation_item_diff_snapshot)
            update(relation.mapping, relation_item_diff_snapshot, ar_object)
          else
            ar_object = @ar_map.ar_object(relation_item_diff_snapshot.object)
            update(relation.mapping, relation_item_diff_snapshot, ar_object)
          end
        end
      end

      def update_single_relation(relation, relation_snapshot, parent_ar_object)
        if relation_snapshot.new?
          # TODO: support STI/polymporphism
          ar_object = build(relation, parent_ar_object, relation_snapshot)
          update(relation.mapping, relation_snapshot, ar_object)
        else
          ar_object = @ar_map.ar_object(relation_snapshot.object)
          update(relation.mapping, relation_snapshot, ar_object)
        end
      end
    end
  end
end
