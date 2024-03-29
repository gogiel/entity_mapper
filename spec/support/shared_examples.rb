# typed: false
# frozen_string_literal: true

# rubocop:disable Metrics/ParameterLists
RSpec.shared_examples "relation" do |name:, persistence_name:, mapping:, options:, virtual: false, collection: false|
  if virtual
    it "is virtual" do
      expect(subject.virtual?).to eq true
    end
  else
    it "is not virtual" do
      expect(subject.virtual?).to eq false
    end
  end

  if collection
    it "is a collection" do
      expect(subject.collection?).to eq true
    end
  else
    it "is not a collection" do
      expect(subject.collection?).to eq false
    end
  end

  it "sets name" do
    expect(subject.name).to eq name
  end

  it "sets persistence_name" do
    expect(subject.persistence_name).to eq persistence_name
  end

  it "sets mapping" do
    expect(subject.mapping).to eq mapping
  end

  it "sets options" do
    expect(subject.options).to eq options
  end
end
# rubocop:enable Metrics/ParameterLists
