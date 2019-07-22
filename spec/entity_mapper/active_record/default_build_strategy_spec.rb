# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::DefaultBuildStrategy do
  subject { described_class.call(relation, parent_ar_object, _diff_snapshot) }
  let(:_diff_snapshot) { double }

  context "when relation is a collection" do
    let(:relation) { instance_double EntityMapper::Mapping::Relation, collection?: true, persistence_name: :order_items }
    let(:new_item) { instance_double OrderItem }
    let(:order_items_relation) { double new: new_item }
    let(:parent_ar_object) { instance_double Order, order_items: order_items_relation }

    it "calls new on the relation" do
      expect(subject).to eq new_item
    end
  end

  context "when relation is not a collection" do
    let(:relation) { instance_double EntityMapper::Mapping::Relation, collection?: false, persistence_name: :customer }
    let(:new_customer) { instance_double Customer }
    let(:parent_ar_object) { instance_double Order, build_customer: new_customer }

    it "calls build_[relation_name]" do
      expect(subject).to eq new_customer
    end
  end
end
