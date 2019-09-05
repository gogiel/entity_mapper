# typed: strong

module EntityMapper
  module ActiveRecord
    class ArMap
      sig { params(object: T.untyped, ar_model: ::ActiveRecord::Base).void }
      def []=(object, ar_model)
      end

      sig { params(object: T.untyped).returns(::ActiveRecord::Base) }
      def [](object)
      end
    end
  end
end
