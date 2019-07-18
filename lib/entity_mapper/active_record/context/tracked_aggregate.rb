# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    class Context
      class TrackedAggregate
        def initialize(aggregate, ar_map, active_record_object, mapping)
          @aggregate = aggregate
          @ar_map = ar_map
          @active_record_object = active_record_object
          @mapping = mapping
          @initial_snapshot = take_snapshot
        end

        def save_changes
          ActiveRecord::Update.new(@ar_map).update(@mapping, snapshot_diff, @active_record_object)
        end

        private

        def snapshot_diff
          EntityMapper::SnapshotDiff::Calculate.new.call(@initial_snapshot, take_snapshot)
        end

        def take_snapshot
          Snapshot::TakeSnapshot.new.call(@aggregate, @mapping)
        end
      end
    end
  end
end
