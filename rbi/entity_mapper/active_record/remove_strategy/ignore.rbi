# typed: strong

module EntityMapper
  module ActiveRecord
    module RemoveStrategy
      class Ignore
        include Abstract
        def call(_ar_object); end
      end
    end
  end
end
