# frozen_string_literal: true

module EntityMapper
  class ZeitwerkInfelctor < Zeitwerk::GemInflector
    def camelize(_basename, _abspath)
      super.sub(/Dsl\z/, "DSL")
    end
  end
end
