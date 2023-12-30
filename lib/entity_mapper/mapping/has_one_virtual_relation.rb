# typed: true
# frozen_string_literal: true

module EntityMapper
  module Mapping
    class HasOneVirtualRelation < HasOneRelation
      def initialize(name, mapping, options)
        super(name, nil, mapping, options)
      end

      def virtual?
        true
      end
    end
  end
end
