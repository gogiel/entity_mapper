# typed: true
module EntityMapper
  module AccessModes
    class Method
      extend T::Sig
      extend T::Helpers
      include Abstract

      def read_from(object); end

      def write_to(object, value); end
    end
  end
end
