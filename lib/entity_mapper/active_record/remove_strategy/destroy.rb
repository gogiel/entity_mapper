# frozen_string_literal: true

module EntityMapper
  module ActiveRecord
    module RemoveStrategy
      class Destroy
        def call(ar_object)
          ar_object.destroy
        end

        def update_nested?
          true
        end
      end
    end
  end
end
