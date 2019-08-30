# typed: true
# frozen_string_literal: true

module EntityMapper
  module AccessModes
    class Null
      def read_from(_object)
        nil
      end

      def write_to(_object, _value)
        nil
      end
    end
  end
end
