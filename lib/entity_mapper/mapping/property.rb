# frozen_string_literal: true

module EntityMapper
  module Mapping
    class Property
      attr_reader :peristence_name, :name

      def initialize(name, peristence_name, options)
        @peristence_name = peristence_name
        @name = name.to_s
        @access = options.fetch(:access, :instance_variable)
      end

      def read_from(object)
        accessor.read_from(object)
      end

      def write_to(object, value)
        accessor.write_to(object, value)
      end

      private

      def accessor
        @accessor ||= AccessModes::Factory.call(@access, @name)
      end
    end
  end
end
