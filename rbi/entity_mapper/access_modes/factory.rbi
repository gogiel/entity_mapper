# typed: true
module EntityMapper
  module AccessModes
    class Factory
      sig { params(access_mode: Symbol, name: T.any(Symbol, String)).returns(Abstract) }
      def self.call(access_mode, name); end
    end
  end
end