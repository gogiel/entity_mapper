# typed: true
# frozen_string_literal: true

module TestEntities
  class OrderItemComment
    attr_accessor :content

    def initialize(content)
      @content = content
    end
  end
end
