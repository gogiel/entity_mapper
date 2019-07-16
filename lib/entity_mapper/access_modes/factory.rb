# frozen_string_literal: true

module EntityMapper
  module AccessModes
    class Factory
      def self.call(access_mode, name)
        case access_mode
        when :instance_variable
          InstanceVariable.new(name)
        when :method
          Method.new(name)
        else
          raise "Access mode #{access_mode} not supported."
        end
      end
    end
  end
end
