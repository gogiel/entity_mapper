# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::Mapping::Property do
  let(:accessor) { double :accessor, read_from: "read-value", write_to: nil }
  let(:accessor2) { double :accessor, read_from: "read-value", write_to: nil }

  before do
    allow(EntityMapper::AccessModes::Factory).to receive(:call) { accessor }
  end

  let(:name) { "param-name" }
  let(:persistence_name) { "persistence-name" }
  let(:options) { {} }

  describe "init" do
    subject { described_class.new(name, persistence_name, options) }

    it "sets name" do
      expect(subject.name).to eq name
    end

    it "sets persistence_name" do
      expect(subject.persistence_name).to eq persistence_name
    end

    it "sets options" do
      expect(subject.options).to eq options
    end
  end

  describe "#read_from" do
    let(:object) { double :object }

    subject(:read_value) { described_class.new(name, persistence_name, options).read_from(object) }

    it "returns value from the accessor" do
      expect(read_value).to eq "read-value"
    end

    it "uses instance_variable accessor by default" do
      read_value

      expect(EntityMapper::AccessModes::Factory).
        to have_received(:call).with(:instance_variable, "param-name").twice
    end

    context "custom accessor" do
      let(:options) { { access: :test } }

      it "returns value from the accessor" do
        expect(read_value).to eq "read-value"
        expect(accessor).to have_received(:read_from).with(object)
      end

      it "uses custom accessor" do
        read_value

        expect(EntityMapper::AccessModes::Factory).
          to have_received(:call).with(:test, "param-name").twice
      end
    end

    context "custom read accessor" do
      let(:options) { { read_access: :test } }

      it "reads value using custom accessor" do
        expect(EntityMapper::AccessModes::Factory).
          to receive(:call).with(:test, "param-name").and_return(accessor2)

        read_value

        expect(accessor2).to have_received(:read_from).with(object)
        expect(accessor).not_to have_received(:read_from)
      end
    end

    context "custom write accessor" do
      let(:options) { { write_access: :test } }

      it "doesn't read value using custom accessor" do
        expect(EntityMapper::AccessModes::Factory).
          to receive(:call).with(:test, "param-name").and_return(accessor2)

        read_value

        expect(accessor).to have_received(:read_from).with(object)
        expect(accessor2).not_to have_received(:read_from)
      end
    end
  end

  describe "#write_to" do
    let(:object) { double :object }
    let(:value) { double :value }

    subject(:write_value) { described_class.new(name, persistence_name, options).write_to(object, value) }

    it "writes value" do
      write_value

      expect(accessor).to have_received(:write_to).with(object, value)
    end

    it "uses instance_variable accessor by default" do
      write_value

      expect(EntityMapper::AccessModes::Factory).
        to have_received(:call).with(:instance_variable, "param-name").twice
    end

    context "custom accessor" do
      let(:options) { { access: :test } }

      it "writes value" do
        write_value

        expect(accessor).to have_received(:write_to).with(object, value)
      end

      it "uses custom accessor" do
        write_value

        expect(EntityMapper::AccessModes::Factory).
          to have_received(:call).with(:test, "param-name").twice
      end
    end

    context "custom write accessor" do
      let(:options) { { write_access: :test } }

      it "writes value using custom accessor" do
        expect(EntityMapper::AccessModes::Factory).
          to receive(:call).with(:test, "param-name").and_return(accessor2)

        write_value

        expect(accessor2).to have_received(:write_to).with(object, value)
        expect(accessor).not_to have_received(:write_to)
      end
    end

    context "custom read accessor" do
      let(:options) { { read_access: :test } }

      it "doesn't use read accessor for write" do
        expect(EntityMapper::AccessModes::Factory).
          to receive(:call).with(:test, "param-name").and_return(accessor2)

        write_value

        expect(accessor).to have_received(:write_to).with(object, value)
        expect(accessor2).not_to have_received(:write_to)
      end
    end
  end
end
