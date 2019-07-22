# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::AccessModes::Factory do
  let(:name) { "variable_name" }
  subject { described_class.call(access_mode, name) }

  describe "instance_variable mode" do
    let(:access_mode) { :instance_variable }

    it "returns corresponding instance" do
      instance = instance_double EntityMapper::AccessModes::InstanceVariable
      allow(EntityMapper::AccessModes::InstanceVariable).to receive(:new).with(name) { instance }

      expect(subject).to eq instance
    end
  end

  describe "method mode" do
    let(:access_mode) { :method }

    it "returns corresponding instance" do
      instance = instance_double EntityMapper::AccessModes::Method
      allow(EntityMapper::AccessModes::Method).to receive(:new).with(name) { instance }

      expect(subject).to eq instance
    end
  end

  describe "unknown mode" do
    let(:access_mode) { :unknown }

    it "raises exception" do
      expect { subject }.to raise_exception("Access mode unknown not supported.")
    end
  end
end
