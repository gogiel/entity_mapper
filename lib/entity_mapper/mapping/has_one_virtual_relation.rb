# frozen_string_literal: true

module EntityMapper
  module Mapping
    class HasOneVirtualRelation < HasOneRelation
      def initialize(name, mapping, options)
        persistence_name = nil
        super name, persistence_name, mapping, options
      end

      def virtual?
        true
      end
    end
  end
end
