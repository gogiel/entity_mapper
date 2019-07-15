# frozen_string_literal: true

class OrderItemOwner < ApplicationRecord
  belongs_to :order_item
end
