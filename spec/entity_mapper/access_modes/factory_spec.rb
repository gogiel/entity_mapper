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

  describe "null mode" do
    let(:access_mode) { :null }

    it "returns corresponding instance" do
      instance = instance_double EntityMapper::AccessModes::Null
      allow(EntityMapper::AccessModes::Null).to receive(:new) { instance }

      expect(subject).to eq instance
    end
  end

  describe "unknown symbol mode" do
    let(:access_mode) { :unknown }

    it "raises exception" do
      expect { subject }.to raise_exception("Access mode unknown not supported.")
    end
  end

  describe "custom mode" do
    let(:access_mode) { double }

    it "returns mode object with no changes" do
      expect(subject).to eq access_mode
    end
  end
end
