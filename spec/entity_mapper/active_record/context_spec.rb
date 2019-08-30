# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::Context do
  let(:mapping1) { instance_double EntityMapper::Mapping::Model }
  let(:active_record_object1) { instance_double ActiveRecord::Base }
  let(:mapped_entity1) { double }
  let(:ar_map1) { instance_double EntityMapper::ActiveRecord::ArMap }

  let(:mapping2) { instance_double EntityMapper::Mapping::Model }
  let(:active_record_object2) { instance_double ActiveRecord::Base }
  let(:mapped_entity2) { double }
  let(:ar_map2) { instance_double EntityMapper::ActiveRecord::ArMap }

  let(:tracked_aggregate1) { instance_double EntityMapper::ActiveRecord::TrackedAggregate, save_changes: nil }
  let(:tracked_aggregate2) { instance_double EntityMapper::ActiveRecord::TrackedAggregate, save_changes: nil }

  let(:create_mapping) { EntityMapper::Mapping::Model }
  let(:create_entity) { double }
  let(:new_ar_object) { double }
  let(:create_active_record_class) { instance_double Class, new: new_ar_object }
  let(:new_aggreagate) { instance_double EntityMapper::ActiveRecord::TrackedAggregate, save_changes: nil }

  before do
    allow(EntityMapper::ActiveRecord::Read).to receive(:call).with(mapping1, active_record_object1).
      and_return([mapped_entity1, ar_map1])
    allow(EntityMapper::ActiveRecord::Read).to receive(:call).with(mapping2, active_record_object2).
      and_return([mapped_entity2, ar_map2])

    allow(EntityMapper::ActiveRecord::TrackedAggregate).to receive(:new).
      with(mapped_entity1, ar_map1, active_record_object1, mapping1).
      and_return(tracked_aggregate1)
    allow(EntityMapper::ActiveRecord::TrackedAggregate).to receive(:new).
      with(mapped_entity2, ar_map2, active_record_object2, mapping2).
      and_return(tracked_aggregate2)
    allow(EntityMapper::ActiveRecord::TrackedAggregate).to receive(:new).
      with(create_entity, kind_of(EntityMapper::ActiveRecord::ArMap), new_ar_object, create_mapping).
      and_return(new_aggreagate)
  end

  let(:call) do
    described_class.new.call do |context|
      @result = context.read(mapping1, active_record_object1)
      context.read(mapping2, active_record_object2)
      context.create(create_mapping, create_entity, create_active_record_class)
    end
  end

  it "saves read entity" do
    call
    expect(tracked_aggregate1).to have_received(:save_changes)
    expect(tracked_aggregate1).to have_received(:save_changes)
    expect(new_aggreagate).to have_received(:save_changes)
  end

  it "uses transaction" do
    allow(ActiveRecord::Base).to receive(:transaction).and_yield
    call
    expect(ActiveRecord::Base).to have_received(:transaction)
  end

  context "custom transaction_class" do
    let(:transaction_class) do
      double.tap do |transaction_class|
        allow(transaction_class).to receive(:transaction).and_yield
      end
    end

    let(:call) do
      described_class.new(transaction_class: transaction_class).call do |context|
        @result = context.read(mapping1, active_record_object1)
        context.read(mapping2, active_record_object2)
        context.create(create_mapping, create_entity, create_active_record_class)
      end
    end

    it "saves read entity" do
      call
      expect(tracked_aggregate1).to have_received(:save_changes)
      expect(tracked_aggregate2).to have_received(:save_changes)
      expect(new_aggreagate).to have_received(:save_changes)
    end

    it "calls transaction on custom transaction_class" do
      call
      expect(transaction_class).to have_received(:transaction)
    end
  end

  describe "reading" do
    it "returns mapped_entity" do
      call
      expect(@result).to eq mapped_entity1
    end
  end
end
