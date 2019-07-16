# frozen_string_literal: true

RSpec.describe EntityMapper::SnapshotDiff::Calculate do
  let(:order) do
    TestEntities::Order.new(customer: customer).tap do |order|
      order.add_item(item1)
      order.add_item(item2)
    end
  end

  let(:customer) { TestEntities::Customer.new("Robert") }
  let(:owner1) { TestEntities::Owner.new("John") }
  let(:owner2) { TestEntities::Owner.new("Mike") }
  let(:comment1) { TestEntities::OrderItemComment.new("comment one")}
  let(:comment2) { TestEntities::OrderItemComment.new("comment two")}
  let(:item1) { TestEntities::OrderItem.new("Test Item", 2, price, owner: owner1, comments: [comment1] ) }
  let(:item2) { TestEntities::OrderItem.new("Test Item 2", 5, price, owner: owner2, comments: [comment2]) }

  let(:price) { TestEntities::Price.new(5, currency) }
  let(:price2) { TestEntities::Price.new(3, currency) }

  let(:currency) { TestEntities::Currency.new("USD") }

  let(:map) { TestMapping }
  let(:items_relation_definition) { map.relation_by_name "items" }
  let(:customer_relation_definition) { map.relation_by_name "customer"}
  let(:item_comments_relation_definition) { items_relation_definition.mapping.relation_by_name "comments"}
  let(:item_owner_relation_definition) { items_relation_definition.mapping.relation_by_name "owner" }

  def take_snapshot
    EntityMapper::Snapshot::TakeSnapshot.new.call(order, map)
  end

  let!(:snapshot1) { take_snapshot }

  subject(:diff) { described_class.new.call(snapshot1, take_snapshot) }

  context "current snapshot is nil" do
    subject(:diff) { described_class.new.call(snapshot1, nil) }

    it "is marked as removed" do
      expect(diff).to be_removed
    end

    describe "collection relation" do
      it "is marked as removed" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        expect(item_snapshot).to be_removed
        expect(item_snapshot.object).to eq item1
      end
    end

    describe "nested collection relation" do
      it "is marked as removed" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        comments_relation_snapshot = item_snapshot.relations_map[item_comments_relation_definition]
        comment_snapshot = comments_relation_snapshot.first
        expect(comment_snapshot).to be_removed
        expect(comment_snapshot.object).to eq comment1
      end
    end

    describe "nested singular relation" do
      it "is marked as removed" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        owner_snapshot = item_snapshot.relations_map[item_owner_relation_definition]
        expect(owner_snapshot).to be_removed
        expect(owner_snapshot.object).to eq owner1
      end
    end

    describe "singular relation" do
      it "is marked as removed" do
        customer_snapshot = diff.relations_map[customer_relation_definition]
        expect(customer_snapshot).to be_removed
        expect(customer_snapshot.object).to eq customer
      end
    end
  end

  context "previous snapshot is nil" do
    subject(:diff) { described_class.new.call(nil, snapshot1) }

    it "is marked as new" do
      expect(diff).to be_new
    end

    describe "collection relation" do
      it "is marked as new" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        expect(item_snapshot).to be_new
        expect(item_snapshot.object).to eq item1
      end
    end

    describe "nested collection relation" do
      it "is marked as new" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        comments_relation_snapshot = item_snapshot.relations_map[item_comments_relation_definition]
        comment_snapshot = comments_relation_snapshot.first
        expect(comment_snapshot).to be_new
        expect(comment_snapshot.object).to eq comment1
      end
    end

    describe "nested singular relation" do
      it "is marked as new" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        owner_snapshot = item_snapshot.relations_map[item_owner_relation_definition]
        expect(owner_snapshot).to be_new
        expect(owner_snapshot.object).to eq owner1
      end
    end

    describe "singular relation" do
      it "is marked as new" do
        customer_snapshot = diff.relations_map[customer_relation_definition]
        expect(customer_snapshot).to be_new
        expect(customer_snapshot.object).to eq customer
      end
    end
  end

  context "no changes" do
    it "is marked as unchanged" do
      expect(diff).to be_unchanged
    end

    describe "collection relation" do
      it "is marked as unchanged" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        expect(item_snapshot).to be_unchanged
        expect(item_snapshot.object).to eq item1
      end
    end

    describe "nested collection relation" do
      it "is marked as unchanged" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        comments_relation_snapshot = item_snapshot.relations_map[item_comments_relation_definition]
        comment_snapshot = comments_relation_snapshot.first
        expect(comment_snapshot).to be_unchanged
        expect(comment_snapshot.object).to eq comment1
      end
    end

    describe "nested singular relation" do
      it "is marked as unchanged" do
        items_relation_snapshot = diff.relations_map[items_relation_definition]
        item_snapshot = items_relation_snapshot.first
        owner_snapshot = item_snapshot.relations_map[item_owner_relation_definition]
        expect(owner_snapshot).to be_unchanged
        expect(owner_snapshot.object).to eq owner1
      end
    end

    describe "singular relation" do
      it "is marked as unchanged" do
        customer_snapshot = diff.relations_map[customer_relation_definition]
        expect(customer_snapshot).to be_unchanged
        expect(customer_snapshot.object).to eq customer
      end
    end
  end

  context "an item from collection is removed" do
    before { order.remove_item item1 }

    it "is marked as removed and appended to the existing items list" do
      items_relation_snapshot = diff.relations_map[items_relation_definition]

      expect(items_relation_snapshot.length).to eq 2
      existing_item_snapshot = items_relation_snapshot[0]
      removed_item_snapshot = items_relation_snapshot[1]

      expect(existing_item_snapshot).to be_unchanged
      expect(removed_item_snapshot).to be_removed
      expect(removed_item_snapshot.object).to eq item1
    end
  end

  context "diff with updated snapshot of the object" do
    it "is not changed" do
      expect(diff).not_to be_changed
    end

    context "changed object" do
      before { order.pay! }

      it "is changed" do
        expect(diff).to be_changed
      end
    end

    context "multiple changes" do
      let(:new_item) do
        price = TestEntities::Price.new(3, TestEntities::Currency.new("USD"))
        owner = TestEntities::Owner.new("John")
        TestEntities::OrderItem.new("Test New Item", 5, price, owner: owner)
      end

      before do
        order.remove_item(item1)
        order.add_item(new_item)
        item2.name = "Item 2 new name"
      end

      it "is not changed" do
        expect(diff).not_to be_changed
      end

      it "marks items changed in the relation" do
        relation = map.relation_by_name "items"
        relation_items = diff.relations_map[relation]

        expect(relation_items[0]).to be_changed
        expect(relation_items[0].object).to eq item2
        expect(relation_items[1]).to be_new
        expect(relation_items[1].object).to eq new_item
        expect(relation_items[2]).to be_removed
        expect(relation_items[2].object).to eq item1

        owner_relation = relation.mapping.relation_by_name("owner")
        first_name_property = owner_relation.mapping.property_by_name "first_name"
        price_relation = relation.mapping.relation_by_name("price")
        value_property = price_relation.mapping.property_by_name("value")

        owner_diff = relation_items[1].relations_map[owner_relation]
        expect(owner_diff).to be_new
        expect(owner_diff.properties_map[first_name_property]).to eq "John"

        owner_diff = relation_items[0].relations_map[owner_relation]
        expect(owner_diff).to be_unchanged
        expect(owner_diff.properties_map[first_name_property]).to eq "Mike"

        price_diff = relation_items[0].relations_map[price_relation]
        expect(price_diff).to be_unchanged
        expect(price_diff.properties_map[value_property]).to eq 5
      end
    end
  end
end
