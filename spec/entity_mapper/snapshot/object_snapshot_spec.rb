# frozen_string_literal: true

RSpec.describe EntityMapper::Snapshot::ObjectSnapshot do
  subject do
    described_class.new(
      object: "fake-object",
      properties_map: "fake-properties_map",
      relations_map: "fake-relations_map"
    )
  end

  it "has accessors" do
    expect(subject.object).to eq "fake-object"
    expect(subject.properties_map).to eq "fake-properties_map"
    expect(subject.relations_map).to eq "fake-relations_map"
  end
end
