# typed: strong
# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items
  has_many :order_tags
  has_many :tags, through: :order_tags
  belongs_to :customer
end
