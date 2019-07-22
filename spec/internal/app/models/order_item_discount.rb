# typed: strong
# frozen_string_literal: true

class OrderItemDiscount < ApplicationRecord
  belongs_to :order_item
end
