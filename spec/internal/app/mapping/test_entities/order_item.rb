# typed: true
# frozen_string_literal: true

module TestEntities
  class OrderItem
    attr_accessor :name, :quantity, :price, :owner, :discount, :ready

    def initialize(name, quantity, price, owner: nil, comments: [])
      @name = name
      @quantity = quantity
      @price = price
      @comments = comments
      @owner = owner
      @discount = nil
    end
  end
end
