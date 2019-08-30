# typed: true
# frozen_string_literal: true

module EntityMapper
  module Mapping
    class Property
      attr_reader :persistence_name, :name, :options

      def initialize(name, persistence_name, options)
        @persistence_name = persistence_name
        @name = name
        @options = options

        default_access = options[:access] || :instance_variable
        read_access = options[:read_access] || default_access
        write_access = options[:write_access] || default_access

        @read_accessor = AccessModes::Factory.call(read_access, name)
        @write_accessor = AccessModes::Factory.call(write_access, name)
      end

      def read_from(object)
        if @read_accessor.respond_to?(:read_from)
          @read_accessor.read_from object
        else
          @read_accessor.call object
        end
      end

      def write_to(object, value)
        if @write_accessor.respond_to?(:write_to)
          @write_accessor.write_to object, value
        else
          @write_accessor.call object, value
        end
      end
    end
  end
end
