module EntityMapper
  class ZeitwerkInfelctor < Zeitwerk::GemInflector
    def camelize(basename, abspath)
      case basename
      when "dsl"
        "DSL"
      when /_dsl$/
        super.gsub("Dsl", "DSL")
      else
        super
      end
    end
  end
end
