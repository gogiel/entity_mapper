# frozen_string_literal: true

module TestEntities
  class Order
    attr_accessor :name, :tags, :customer

    def initialize(name = "", customer: nil)
      @name = name
      @paid = false
      @tags = []
      @items = []
      @customer = customer
    end

    def pay!
      @paid = true
    end

    def refund!
      @paid = false
    end

    def paid?
      @paid
    end

    def clear!
      @items = []
    end

    def add_item(item)
      items << item
    end

    def remove_item(item)
      @items.delete item
    end

    def items
      @items ||= []
    end
  end
end
