# typed: true
# frozen_string_literal: true

module EntityMapper
  module SnapshotDiff
    class Calculate
      def self.call(previous_snapshot, current_snapshot)
        new(previous_snapshot, current_snapshot).call
      end

      def initialize(previous_snapshot, current_snapshot)
        @previous_snapshot = previous_snapshot
        @current_snapshot = current_snapshot
      end

      attr_reader :previous_snapshot, :current_snapshot

      def call
        state = diff_state

        object = current_snapshot || previous_snapshot

        ObjectDiffSnapshot.new(
          object: object.object,
          properties_map: object.properties_map,
          relations_map: relations_map,
          state: state
        )
      end

      def diff_state
        if previous_snapshot.nil?
          :new
        elsif current_snapshot.nil?
          :removed
        elsif properties_changed?
          :changed
        else
          :unchanged
        end
      end

      def properties_changed?
        current_snapshot.properties_map.any? do |property, value|
          !value.equal? previous_snapshot.properties_map.fetch(property)
        end
      end

      def relations_map
        relations = (current_snapshot || previous_snapshot).relations_map.keys

        relations.each_with_object({}) do |relation, hash|
          current_relation_value = read_value(current_snapshot, relation)
          previous_relation_value = read_value(previous_snapshot, relation)
          hash[relation] = if relation.collection?
            collection_diff(previous_relation_value, current_relation_value)
          else
            self.class.call(previous_relation_value, current_relation_value)
          end
        end
      end

      def read_value(snapshot, relation)
        snapshot&.relations_map&.fetch(relation)
      end

      def collection_diff(previous_relation_value, current_relation_value)
        existing_items = current_relation_value.to_a.map do |value|
          self.class.call(find_previous_snapshot(previous_relation_value, value), value)
        end
        removed_items = previous_relation_value.to_a.
                        reject { |value| find_previous_snapshot(current_relation_value, value) }.
                        map { |value| self.class.call(value, nil) }

        existing_items + removed_items
      end

      def find_previous_snapshot(previous_relation_value, value)
        previous_relation_value&.find { |v| v.object.equal? value.object }
      end
    end
  end
end
