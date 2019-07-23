# typed: true
module EntityMapper
  module ActiveRecord
    class Context
      class TrackedAggregate
        sig { params(aggregate: T.untyped, ar_map: ArMap, active_record_object: ::ActiveRecord::Base, mapping: Mapping::Model).void }
        def initialize(aggregate, ar_map, active_record_object, mapping)
        end

        sig { void }
        def save_changes
        end

        private

        sig { returns(SnapshotDiff::ObjectDiffSnapshot) }
        def snapshot_diff
        end

        sig { returns(Snapshot::ObjectSnapshot) }
        def take_snapshot
        end
      end
    end
  end
end
