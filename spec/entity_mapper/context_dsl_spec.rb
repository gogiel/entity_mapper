# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::ContextDSL do
  let(:context) { spy }

  subject { described_class.new(context) }

  describe "#read" do
    it "delegates to context" do
      subject.read("mapping", "persisted_object")
      expect(context).to have_received(:read).with("mapping", "persisted_object")
    end
  end

  describe "#create" do
    it "delegates to context" do
      subject.create("mapping", "entity", "persistence_reference")
      expect(context).to have_received(:create).with("mapping", "entity", "persistence_reference")
    end
  end
end
