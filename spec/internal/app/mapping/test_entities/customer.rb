# frozen_string_literal: true

module TestEntities
  class Customer
    attr_accessor :first_name

    def initialize(first_name)
      @first_name = first_name
    end
  end
end
