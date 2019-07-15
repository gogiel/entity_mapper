# frozen_string_literal: true

module TestEntities
  class OrderItem
    attr_accessor :name, :quantity, :price

    def initialize(name, quantity, price)
      @name = name
      @quantity = quantity
      @price = price
      @comments = []
      @owner = nil
    end
  end
end
