module EntityMapper
  module Mapping
    class HasManyRelation < Relation
      def collection?
        true
      end
    end
  end
end
