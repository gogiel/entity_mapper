# typed: true

module EntityMapper
  module ActiveRecord
    class Update
      sig { params(ar_map: ArMap).void }
      def initialize(ar_map)
      end

      sig { params(mapping: Mapping::Model, snapshot_diff: SnapshotDiff::ObjectDiffSnapshot, ar_object: ::ActiveRecord::Base).void }
      def update(mapping, snapshot_diff, ar_object)
      end

      private

      sig { params(properties: T::Array[Mapping::Property], object: T.untyped, ar_object: ::ActiveRecord::Base).void }
      def map_properties(properties, object, ar_object)
      end

      sig { params(relations: T::Array[Mapping::Relation], snapshot_diff: SnapshotDiff::ObjectDiffSnapshot, parent_ar_object: ::ActiveRecord::Base).void }
      def map_relations(relations, snapshot_diff, parent_ar_object)
      end

      sig { params(relation: Mapping::Relation, parent_ar_object: ::ActiveRecord::Base, relation_item_diff_snapshot: SnapshotDiff::ObjectDiffSnapshot).returns(T.any(::ActiveRecord::Base, T::Array[::ActiveRecord::Base])) }
      def build(relation, parent_ar_object, relation_item_diff_snapshot)
      end

      sig { params(relation: Mapping::Relation, parent_ar_object: ::ActiveRecord::Base, relation_snapshot: T::Array[SnapshotDiff::ObjectDiffSnapshot]).void }
      def update_collection_relation(relation, relation_snapshot, parent_ar_object)
      end

      sig { params(relation: Mapping::Relation, parent_ar_object: ::ActiveRecord::Base, relation_snapshot: SnapshotDiff::ObjectDiffSnapshot).void }
      def update_single_item(relation, relation_snapshot, parent_ar_object)
      end
    end
  end
end
