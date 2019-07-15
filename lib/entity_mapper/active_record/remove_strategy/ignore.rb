# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    module RemoveStrategy
      class Ignore
        def call(_ar_object); end
      end
    end
  end
end
