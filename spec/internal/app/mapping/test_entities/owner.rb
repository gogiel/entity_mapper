# frozen_string_literal: true

module TestEntities
  class Owner
    attr_accessor :name

    def initialize(name)
      @name = name
    end
  end
end
