module EntityMapper
  module ActiveRecord
    class ArMap
      def initialize
        @map = {}
      end

      def add_entity(object, ar_model)
        @map[object] = ar_model
      end

      def ar_object(object)
        @map.fetch(object)
      end
    end
  end
end
