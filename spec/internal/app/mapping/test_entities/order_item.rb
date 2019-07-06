module TestEntities
  class OrderItem
    attr_accessor :name, :quantity, :price

    def initialize(name, quantity, price)
      @name = name
      @quantity = quantity
      @price = price
    end
  end
end
