# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::AccessModes::InstanceVariable do
  subject { described_class.new("my_variable") }

  let(:fake_class) do
    Class.new do
      attr_reader :my_variable

      def initialize
        @my_variable = 5
      end
    end
  end

  let(:sample_object) { fake_class.new }

  describe "#read_from" do
    it "reads instance variable from object" do
      result = subject.read_from sample_object
      expect(result).to eq 5
    end
  end

  describe "#write_to" do
    it "writes instance variable to object" do
      subject.write_to sample_object, 6
      expect(sample_object.my_variable).to eq 6
    end
  end
end
