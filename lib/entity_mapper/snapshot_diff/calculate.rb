# frozen_string_literal: true

module EntityMapper
  module SnapshotDiff
    class Calculate
      def call(previous_snapshot, current_snapshot)
        state = diff_state(previous_snapshot, current_snapshot)

        object = current_snapshot || previous_snapshot

        ObjectDiffSnapshot.new(
          object: object.object,
          properties_map: object.properties_map,
          relations_map: relations_map(previous_snapshot, current_snapshot),
          state: state
        )
      end

      def diff_state(previous_snapshot, current_snapshot)
        if previous_snapshot.nil?
          :new
        elsif current_snapshot.nil?
          :removed
        elsif properties_changed?(previous_snapshot, current_snapshot)
          :changed
        else
          :unchanged
        end
      end

      def properties_changed?(previous_snapshot, current_snapshot)
        current_snapshot.properties_map.any? do |property, value|
          !value.equal? previous_snapshot.properties_map.fetch(property)
        end
      end

      def relations_map(previous_snapshot, current_snapshot)
        relations = (current_snapshot || previous_snapshot).relations_map.keys

        relations.each_with_object({}) do |relation, hash|
          current_relation_value = read_value(current_snapshot, relation)
          previous_relation_snapshot = read_value(previous_snapshot, relation)
          hash[relation] = if relation.collection?
            collection_diff(previous_relation_snapshot, current_relation_value)
          else
            call(previous_relation_snapshot, current_relation_value)
          end
        end
      end

      def read_value(snapshot, relation)
        snapshot&.relations_map&.fetch(relation)
      end

      def find_previous_snapshot(previous_relation_snapshot, value)
        previous_relation_snapshot&.find { |v| v.object.equal? value.object }
      end

      def collection_diff(previous_relation_snapshot, current_relation_value)
        existing_items = current_relation_value.to_a.map do |value|
          call(find_previous_snapshot(previous_relation_snapshot, value), value)
        end
        removed_items = previous_relation_snapshot.to_a.
                        reject { |value| find_previous_snapshot(current_relation_value, value) }.
                        map { |value| call(value, nil) }

        existing_items + removed_items
      end
    end
  end
end
