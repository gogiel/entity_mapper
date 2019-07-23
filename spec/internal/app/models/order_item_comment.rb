# typed: strong
# frozen_string_literal: true

class OrderItemComment < ApplicationRecord
  belongs_to :order_item
end
