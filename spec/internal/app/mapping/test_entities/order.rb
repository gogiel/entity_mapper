# frozen_string_literal: true

module TestEntities
  class Order
    attr_accessor :name, :tags

    def initialize(name = "")
      @name = name
      @paid = false
      @tags = []
      @items = []
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

    def items
      @items ||= []
    end
  end
end
