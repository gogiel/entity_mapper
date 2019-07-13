module EntityMapper
  module ActiveRecord
    module RemoveStrategy
      def self.find(symbol)
        case symbol
        when :ignore
          Ignore.new
        else
          Destroy.new
        end
      end
    end
  end
end
