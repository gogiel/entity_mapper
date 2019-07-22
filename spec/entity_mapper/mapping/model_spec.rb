# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::Mapping::Model do
  subject { described_class.new }

  describe "defaults" do
    it "has empty model_class" do
      expect(subject.model_class).to be_nil
    end

    it "has nil remove_strategy" do
      expect(subject.remove_strategy).to be_nil
    end

    it "has empty properties" do
      expect(subject.properties).to be_empty
    end

    it "has empty relations" do
      expect(subject.relations).to be_empty
    end
  end

  describe "#remove_strategy=" do
    it "sets remove_strategy" do
      subject.remove_strategy = "test"
      expect(subject.remove_strategy).to eq "test"
    end
  end

  it "manages relations" do
    relation1 = instance_double EntityMapper::Mapping::Relation, name: "test1"
    relation2 = instance_double EntityMapper::Mapping::Relation, name: :test2
    subject.add_relation relation1
    subject.add_relation relation2
    expect(subject.relations.to_a).to eq [relation1, relation2]
    expect(subject.relation_by_name("test1")).to eq relation1
    expect(subject.relation_by_name(:test1)).to eq relation1
    expect(subject.relation_by_name("test2")).to eq relation2
    expect(subject.relation_by_name(:test2)).to eq relation2
  end

  it "manages properties" do
    property1 = instance_double EntityMapper::Mapping::Property, name: "test1"
    property2 = instance_double EntityMapper::Mapping::Property, name: :test2
    subject.add_property property1
    subject.add_property property2
    expect(subject.properties.to_a).to eq [property1, property2]
    expect(subject.property_by_name("test1")).to eq property1
    expect(subject.property_by_name(:test1)).to eq property1
    expect(subject.property_by_name("test2")).to eq property2
    expect(subject.property_by_name(:test2)).to eq property2
  end
end
