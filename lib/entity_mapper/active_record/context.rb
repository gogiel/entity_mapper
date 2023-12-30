# typed: true
# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    class Context
      def initialize(transaction_class: ::ActiveRecord::Base)
        @tracked_aggregates = []
        @transaction_class = transaction_class
      end

      def call
        @transaction_class.transaction do
          yield(self).tap do
            save_changes
          end
        end
      end

      def read(mapping, active_record_object, options = {})
        mapped_entity, ar_map = ActiveRecord::Read.call(mapping, active_record_object, **options)
        @tracked_aggregates << TrackedAggregate.new(
          mapped_entity, ar_map, active_record_object, mapping
        )

        mapped_entity
      end

      def create(mapping, entity, active_record_class)
        active_record_object = active_record_class.new
        new_aggregate = TrackedAggregate.new(
          entity, ArMap.new, active_record_object, mapping
        )
        new_aggregate.save_changes
        @tracked_aggregates << new_aggregate
        active_record_object
      end

      private

      def save_changes
        @tracked_aggregates.each(&:save_changes)
      end
    end
  end
end
