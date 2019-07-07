# frozen_string_literal: true

module TestEntities
  class Tag
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
