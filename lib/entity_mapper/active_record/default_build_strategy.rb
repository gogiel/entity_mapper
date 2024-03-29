# typed: strict
# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    class DefaultBuildStrategy
      def self.call(relation, parent_ar_object, _diff_snapshot)
        if relation.collection?
          parent_ar_object.public_send(relation.persistence_name).new
        else
          parent_ar_object.public_send("build_#{relation.persistence_name}")
        end
      end
    end
  end
end
