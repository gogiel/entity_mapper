# typed: true
module EntityMapper
  module AccessModes
    module Abstract
      interface!

      sig { abstract.params(object: T.untyped).returns(T.untyped) }
      def read_from(object); end

      sig { abstract.params(object: T.untyped, value: T.untyped).void }
      def write_to(object, value); end
    end
  end
end
