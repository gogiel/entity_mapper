# typed: true
# frozen_string_literal: true

module EntityMapper
  module AccessModes
    class Null
      def read_from(_object); end

      def write_to(_object, _value); end
    end
  end
end
