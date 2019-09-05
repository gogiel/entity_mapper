# typed: strong

module EntityMapper
  module ActiveRecord
    module RemoveStrategy
      module Abstract
        interface!

        sig { abstract.params(ar_object: ::ActiveRecord::Base).void }
        def call(ar_object)
        end
      end
    end
  end
end
