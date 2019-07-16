# frozen_string_literal: true

RSpec.describe EntityMapper::SnapshotDiff::ObjectDiffSnapshot do
  let(:state) { "fake-state" }
  subject do
    described_class.new(
      object: "fake-object",
      properties_map: "fake-properties_map",
      relations_map: "fake-relations_map",
      state: state
    )
  end

  it "has accessors" do
    expect(subject.object).to eq "fake-object"
    expect(subject.properties_map).to eq "fake-properties_map"
    expect(subject.relations_map).to eq "fake-relations_map"
  end

  %i[new changed unchanged removed].each do |supported_state|
    method_name = "#{supported_state}?"

    describe "##{method_name}" do
      it "returns false" do
        expect(subject.send(method_name)).to eq false
      end

      context "when state is #{supported_state}" do
        let(:state) { supported_state }

        it "returns true" do
          expect(subject.send(method_name)).to eq true
        end
      end
    end
  end
end
