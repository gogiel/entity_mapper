# typed: strong

module EntityMapper
  module ActiveRecord
    module RemoveStrategy
      class Factory
        sig { params(symbol: Symbol).returns(Abstract) }
        def self.find(symbol)
        end
      end
    end
  end
end
