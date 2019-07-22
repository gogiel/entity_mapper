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
          yield self
          save_changes
        end
      end

      def read(mapping, active_record_object)
        mapped_entity, ar_map = ActiveRecord::Read.call(mapping, active_record_object)
        @tracked_aggregates << TrackedAggregate.new(
          mapped_entity, ar_map, active_record_object, mapping
        )

        mapped_entity
      end

      def create(mapping, entity, active_record_class)
        @tracked_aggregates << TrackedAggregate.new(
          entity, ArMap.new, active_record_class.new, mapping
        )
      end

      private

      def save_changes
        @tracked_aggregates.each(&:save_changes)
      end
    end
  end
end
