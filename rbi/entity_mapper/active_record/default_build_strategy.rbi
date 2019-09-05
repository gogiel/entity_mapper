# typed: strong

module EntityMapper
  module ActiveRecord
    class DefaultBuildStrategy
      sig { params(
        relation: Mapping::Relation,
        parent_ar_object: ::ActiveRecord::Base,
        _diff_snapshot: SnapshotDiff::ObjectDiffSnapshot
       ).returns(T.any(::ActiveRecord::Base, T::Array[::ActiveRecord::Base])) }
      def self.call(relation, parent_ar_object, _diff_snapshot)
      end
    end
  end
end
