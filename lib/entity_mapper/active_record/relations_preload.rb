# typed: true
# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    class RelationsPreload
      def self.call(mapping) # rubocop:disable Metrics/MethodLength
        mapping.relations.map do |relation|
          if relation.virtual?
            call(relation.mapping)
          else
            inner_mapping = call(relation.mapping)
            if inner_mapping.empty?
              relation.persistence_name
            else
              { relation.persistence_name => inner_mapping }
            end
          end
        end.flatten
      end
    end
  end
end
