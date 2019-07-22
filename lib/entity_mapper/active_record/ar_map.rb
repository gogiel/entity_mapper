# typed: true
# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    class ArMap
      def initialize
        @map = {}
      end

      def []=(object, ar_model)
        @map[object] = ar_model
      end

      def [](object)
        @map[object]
      end
    end
  end
end
