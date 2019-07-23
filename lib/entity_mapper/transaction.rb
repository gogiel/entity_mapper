# typed: true
# frozen_string_literal: true

module EntityMapper
  class Transaction
    def self.call(context_class: ActiveRecord::Context, **options)
      context_class.new(options).call do |context|
        yield ContextDSL.new(context)
      end
    end
  end
end
