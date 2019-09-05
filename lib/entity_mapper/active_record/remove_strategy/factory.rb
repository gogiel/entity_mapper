# typed: strong
# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    module RemoveStrategy
      class Factory
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
end
