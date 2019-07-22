# typed: true
# frozen_string_literal: true

module TestEntities
  class Price
    attr_accessor :value
    attr_reader :currency

    def initialize(value, currency)
      @value = value
      @currency = currency
    end
  end
end
