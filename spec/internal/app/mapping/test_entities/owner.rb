# typed: true
# frozen_string_literal: true

module TestEntities
  class Owner
    attr_accessor :first_name

    def initialize(first_name)
      @first_name = first_name
    end

    class Admin
    end
  end
end
