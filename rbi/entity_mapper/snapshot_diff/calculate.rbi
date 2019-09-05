# typed: strong

module EntityMapper
  module SnapshotDiff
    class Calculate
      sig { params(previous_snapshot: T.nilable(Snapshot::ObjectSnapshot), current_snapshot: T.nilable(Snapshot::ObjectSnapshot)).returns(ObjectDiffSnapshot) }
      def self.call(previous_snapshot, current_snapshot)
      end

      sig { params(previous_snapshot: T.nilable(Snapshot::ObjectSnapshot), current_snapshot: T.nilable(Snapshot::ObjectSnapshot)).void }
      def initialize(previous_snapshot, current_snapshot)
      end

      # Can't use it because flow-control doesn't detect complex case
      # sig { returns(T.nilable(Snapshot::ObjectSnapshot)) }
      # def previous_snapshot; end
      # sig { returns(T.nilable(Snapshot::ObjectSnapshot)) }
      # def current_snapshot; end

      sig { returns(ObjectDiffSnapshot) }
      def call
      end

      sig { returns(Symbol) }
      def diff_state
      end

      sig { returns(T::Boolean) }
      def properties_changed?
      end

      sig { returns(T::Hash[Mapping::Relation, ObjectDiffSnapshot]) }
      def relations_map
      end

      sig { params(snapshot: T.nilable(Snapshot::ObjectSnapshot), relation: Mapping::Relation).returns(T.untyped)}
      def read_value(snapshot, relation)
      end

      sig { params(previous_relation_value: T::Array[T.untyped], current_relation_value: T::Array[T.untyped]).returns(T::Array[T.untyped]) }
      def collection_diff(previous_relation_value, current_relation_value)
      end
    end
  end
end
