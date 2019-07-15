# frozen_string_literal: true

RSpec.describe EntityMapper::SnapshotDiff::Calculate do
  let(:order) do
    TestEntities::Order.new.tap do |order|
      order.add_item(item)
    end
  end

  let(:item) { TestEntities::OrderItem.new("Test Item", 2, price) }

  let(:price) { TestEntities::Price.new(5, currency) }
  let(:currency) { TestEntities::Currency.new("USD") }

  let(:map) { TestMapping }

  def take_snapshot
    EntityMapper::Snapshot::TakeSnapshot.new.call(order, map)
  end

  let!(:snapshot1) { take_snapshot }

  context "current snapshot is nil" do
    subject(:diff) { described_class.new.call(snapshot1, nil) }

    it "is marked as removed" do
      expect(diff).to be_removed
    end

    context "nested relation" do
      let(:items_relation_definition) { map.relation_by_name "items" }

      it "is marked as removed" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        expect(item_snapshot).to be_removed
      end
    end
  end

  context "previous snapshot is nil" do
    context "current snapshot is nil" do
      subject(:diff) { described_class.new.call(nil, snapshot1) }

      it "is marked as new" do
        expect(diff).to be_new
      end
    end
  end

  context "diff with updated snapshot of the object" do
    subject(:diff) { described_class.new.call(snapshot1, take_snapshot) }

    it "is not changed" do
      expect(diff).not_to be_changed
    end

    context "changed object" do
      before { order.pay! }

      it "is changed" do
        expect(diff).to be_changed
      end
    end

    context "changed relation" do
      let(:new_item) do
        price = TestEntities::Price.new(3, TestEntities::Currency.new("USD"))
        TestEntities::OrderItem.new("Test New Item", 5, price)
      end

      before do
        order.clear!
        order.add_item(new_item)
      end

      it "is not changed" do
        expect(diff).not_to be_changed
      end

      it "marks items changed in the relation" do
        relation = map.relation_by_name "items"
        relation_items = diff.relations_map[relation]

        expect(relation_items[0]).to be_new
        expect(relation_items[0].object).to eq new_item
        expect(relation_items[1]).to be_removed
        expect(relation_items[1].object).to eq item
      end
    end
  end
end
