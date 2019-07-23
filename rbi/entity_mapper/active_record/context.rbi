# typed: true

module EntityMapper
  module ActiveRecord
    class Context
      sig { params(block: T.proc.params(arg0: Context).returns(T.untyped)).void }
      def call(&block)
      end

      sig { params(mapping: Mapping::Model, active_record_object: ::ActiveRecord::Base).returns(T.untyped) }
      def read(mapping, active_record_object)
      end

      sig { params(mapping: Mapping::Model,entity: T.untyped, active_record_class: T.class_of(::ActiveRecord::Base)).void }
      def create(mapping, entity, active_record_class)
      end
    end
  end
end
