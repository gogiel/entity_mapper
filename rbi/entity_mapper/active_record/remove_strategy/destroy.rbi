# typed: true

module EntityMapper
  module ActiveRecord
    module RemoveStrategy
      class Destroy
        include Abstract

        def call(ar_object)
        end
      end
    end
  end
end
