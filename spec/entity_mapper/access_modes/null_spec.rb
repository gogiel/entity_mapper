# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::AccessModes::Null do
  subject { described_class.new }

  describe "#read_from" do
    it "returns nil" do
      result = subject.read_from double
      expect(result).to eq nil
    end
  end

  describe "#write_to" do
    it "doesn't do anything" do
      subject.write_to double, double
    end
  end
end
