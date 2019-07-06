module EntityMapper
  module ActiveRecord
    class Context
      def initialize(mapping)
        @mapping = mapping
        @tracked_aggregates = []
      end

      def call
        ::ActiveRecord::Base.transaction do
          yield self
          save_changes
        end
      end

      def read(active_record_object)
        mapped_entity, ar_map = ActiveRecord::Read.call(@mapping, active_record_object)
        @tracked_aggregates << TrackedAggregate.new(mapped_entity, ar_map, active_record_object, @mapping)

        mapped_entity
      end

      def create(entity, active_record_class)
        @tracked_aggregates << TrackedAggregate.new(entity, ArMap.new, active_record_class.new, @mapping)
      end

      private

      def save_changes
        @tracked_aggregates.each(&:save_changes)
      end
    end
  end
end
