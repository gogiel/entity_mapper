# frozen_string_literal: true

module TestEntities
  class OrderItem
    attr_accessor :name, :quantity, :price, :owner, :discount

    def initialize(name, quantity, price)
      @name = name
      @quantity = quantity
      @price = price
      @comments = []
      @owner = nil
      @discount = nil
    end
  end
end
