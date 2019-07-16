# frozen_string_literal: true

RSpec.describe EntityMapper::ZeitwerkInfelctor do
  describe "#camelize" do
    subject { described_class.new "absolute " }

    it "changes 'dsl' to 'DSL'" do
      expect(subject.camelize("dsl", "absolute")).to eq "DSL"
    end

    it "changes '_dsl' suffix to DSL" do
      expect(subject.camelize("project_dsl", "absolute")).to eq "ProjectDSL"
    end

    it "returns camelized string by default" do
      expect(subject.camelize("test_name", "absolute")).to eq "TestName"
    end
  end
end
