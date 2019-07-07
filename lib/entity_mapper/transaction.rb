# frozen_string_literal: true

module EntityMapper
  class Transaction
    def self.call(context_class: ActiveRecord::Context)
      context_class.new.call do |context|
        yield ContextDSL.new(context)
      end
    end
  end
end
