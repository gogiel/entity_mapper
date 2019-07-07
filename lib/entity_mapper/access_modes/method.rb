# frozen_string_literal: true

module EntityMapper
  module AccessModes
    class Method
      def initialize(name)
        @name = name
      end

      def read_from(object)
        object.send(@name)
      end

      def write_to(object, value)
        object.send("#{@name}=", value)
      end
    end
  end
end
