# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::Context::TrackedAggregate do
  let(:ar_map) { instance_double EntityMapper::ActiveRecord::ArMap }
  let(:active_record_object) { double }
  let(:mapping) { instance_double EntityMapper::Mapping::Model }
  let(:aggregate) { double }
  let(:snapshot_diff) { instance_double EntityMapper::SnapshotDiff::ObjectDiffSnapshot }

  let(:update_instance) { instance_double EntityMapper::ActiveRecord::Update }
  let(:take_snapshot_instance) { instance_double EntityMapper::Snapshot::TakeSnapshot }
  let(:snapshot1) { instance_double EntityMapper::Snapshot::ObjectSnapshot }
  let(:snapshot2) { instance_double EntityMapper::Snapshot::ObjectSnapshot }

  before do
    allow(EntityMapper::ActiveRecord::Update).to receive(:new).with(ar_map) { update_instance }
    allow(EntityMapper::Snapshot::TakeSnapshot).to receive(:new) { take_snapshot_instance }
    allow(EntityMapper::SnapshotDiff::Calculate).to receive(:call) { snapshot_diff }

    allow(take_snapshot_instance).to receive(:call).with(aggregate, mapping).and_return(snapshot1, snapshot2)

    allow(update_instance).to receive(:update)
  end

  subject { described_class.new(aggregate, ar_map, active_record_object, mapping) }

  it "calculates snapshot diff between initial snapshot and current snapshot" do
    subject
    expect(take_snapshot_instance).to have_received(:call).
      with(aggregate, mapping).once
    subject.save_changes
    expect(take_snapshot_instance).to have_received(:call).
      with(aggregate, mapping).twice

    expect(EntityMapper::SnapshotDiff::Calculate).to have_received(:call).
      with(snapshot1, snapshot2)
    expect(update_instance).to have_received(:update).with(
      mapping, snapshot_diff, active_record_object
    )
  end
end
