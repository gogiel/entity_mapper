# typed: strong

module EntityMapper
  module Mapping
    class Model
      sig { returns(T.any(Class, T.proc.params(arg0: ::ActiveRecord::Base).returns(Class))) }
      def model_class; end

      sig { params(model_class: T.any(Class, T.proc.params(arg0: ::ActiveRecord::Base).returns(Class))).void }
      def model_class=(model_class); end

      sig { params(ar_model: ::ActiveRecord::Base).returns(T.untyped) }
      def allocate_model(ar_model); end

      sig { returns(Symbol) }
      def remove_strategy; end

      sig { params(remove_strategy: Symbol).void }
      def remove_strategy=(remove_strategy); end

      sig { returns(T::Array[Mapping::Property]) }
      def properties; end

      sig { returns(T::Array[Mapping::Relation]) }
      def relation; end

      sig { params(relation: Mapping::Relation).void }
      def add_relation(relation)
      end

      sig { params(property: Mapping::Property).void }
      def add_property(property)
      end

      sig { params(name: T.any(String, Symbol)).returns(T.nilable(Mapping::Relation)) }
      def relation_by_name(name)
      end

      sig { params(name: T.any(String, Symbol)).returns(T.nilable(Mapping::Property)) }
      def property_by_name(name)
      end
    end
  end
end
