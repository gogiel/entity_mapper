# frozen_string_literal: true

module EntityMapper
  module SnapshotDiff
    ObjectDiffSnapshot = Struct.new(:object, :properties_map, :relations_map, :state) do
      def new?
        state == :new
      end

      def changed?
        state == :changed
      end

      def removed?
        state == :removed
      end
    end
  end
end
