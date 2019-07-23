# typed: true
# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    module RemoveStrategy
      class Destroy
        def call(ar_object)
          ar_object.destroy
        end
      end
    end
  end
end
