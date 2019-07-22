# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::ZeitwerkInflector do
  describe "#camelize" do
    subject { described_class.new "absolute " }

    it "changes 'dsl' to 'DSL'" do
      expect(subject.camelize("dsl", "absolute")).to eq "DSL"
    end

    it "changes '_dsl' suffix to DSL" do
      expect(subject.camelize("project_dsl", "absolute")).to eq "ProjectDSL"
    end

    it "doesnt change dsl in the prefix" do
      expect(subject.camelize("dsl_test", "absolute")).to eq "DslTest"
    end

    it "doesn't change dsl if part of string" do
      expect(subject.camelize("project_dsla", "absolute")).to eq "ProjectDsla"
    end

    it "returns camelized string by default" do
      expect(subject.camelize("test_name", "absolute")).to eq "TestName"
    end
  end
end
