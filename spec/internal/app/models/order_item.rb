# typed: strong
# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  has_many :comments, class_name: "OrderItemComment"
  has_one :owner, class_name: "OrderItemOwner"
  has_one :discount, class_name: "OrderItemDiscount"
end
