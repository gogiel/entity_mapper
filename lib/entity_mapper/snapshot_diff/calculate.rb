# frozen_string_literal: true

module EntityMapper
  module SnapshotDiff
    class Calculate
      def call(previous_snapshot, current_snapshot)
        state = diff_state(previous_snapshot, current_snapshot)

        object = current_snapshot || previous_snapshot

        ObjectDiffSnapshot.new(
          object.object,
          object.properties_map,
          relations_map(previous_snapshot, current_snapshot),
          state
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
        if previous_snapshot.nil?
          current_snapshot.
            relations_map.
            each_with_object({}) do |(relation, relation_value), hash|
            hash[relation] = relation.collection? ?
              relation_value.map { |value| call(nil, value) } :
              call(nil, relation_value)
          end
        elsif current_snapshot.nil?
          previous_snapshot.
            relations_map.
            each_with_object({}) do |(relation, relation_value), hash|
            hash[relation] = relation.collection? ?
              relation_value.map { |value| call(value, nil) } :
              call(relation_value, nil)
          end
        else
          current_snapshot.
            relations_map.
            each_with_object({}) do |(relation, relation_value), hash|
            previous_snapshot_relation = previous_snapshot.relations_map.fetch(relation)
            hash[relation] = if relation.collection?
              existing_items = relation_value.map { |value| call(find_previous_snapshot(previous_snapshot_relation, value), value) }
              removed_items = previous_snapshot_relation.reject { |value| find_previous_snapshot(relation_value, value) }.map { |value| call(value, nil) }

              existing_items + removed_items
            else
              call(previous_snapshot_relation, relation_value)
            end
          end
        end
      end

      def find_previous_snapshot(previous_snapshot_relation, value)
        previous_snapshot_relation.find { |v| v.object.equal? value.object }
      end
    end
  end
end
