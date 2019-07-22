# typed: true
# frozen_string_literal: true

module EntityMapper
  class ZeitwerkInflector < Zeitwerk::GemInflector
    def camelize(_basename, _abspath)
      super.sub(/Dsl\z/, "DSL")
    end
  end
end
