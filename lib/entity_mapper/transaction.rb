# frozen_string_literal: true

module EntityMapper
  class Transaction
    def self.call(mapping, &block)
      new.call(mapping, &block)
    end

    def call(mapping)
      ActiveRecord::Context.new(mapping).call do |context|
        yield ContextDSL.new(context)
      end
    end
  end
end
