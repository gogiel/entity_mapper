# frozen_string_literal: true

module EntityMapper
  module AccessModes
    class InstanceVariable
      def initialize(name)
        @name = name
      end

      def read_from(object)
        object.instance_variable_get("@#{@name}")
      end

      def write_to(object, value)
        object.instance_variable_set("@#{@name}", value)
      end
    end
  end
end
