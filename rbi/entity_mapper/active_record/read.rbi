# typed: true

module EntityMapper
  module ActiveRecord
    class Read
      sig { params(mapping: Mapping::Model, root: ::ActiveRecord::Base).returns([T.untyped, ArMap]) }
      def self.call(mapping, root)
      end

      sig { params(mapping: Mapping::Model, root: ::ActiveRecord::Base).returns([T.untyped, ArMap]) }
      def call(mapping, root)
      end

      private

      sig { params(mapping: Mapping::Model, ar_model: ::ActiveRecord::Base).returns(T.untyped) }
      def read(mapping, ar_model)
      end

      sig { params(properties: T::Array[Mapping::Property], object: T.untyped, ar_model: ::ActiveRecord::Base).void }
      def read_properties(properties, object, ar_model)
      end

      sig { params(relations: T::Array[Mapping::Relation], object: T.untyped, ar_model: ::ActiveRecord::Base).void }
      def read_relations(relations, object, ar_model)
      end

      sig { params(ar_model: ::ActiveRecord::Base, relation: Mapping::Relation).void }
      def read_ar_relations(ar_model, relation)
      end
    end
  end
end
