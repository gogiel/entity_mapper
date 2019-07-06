RSpec.describe EntityMapper::ActiveRecord::Update do

  let(:map) { TestMapping }
  let(:read_result) { EntityMapper::ActiveRecord::Read.call(map, order) }
  let(:mapped_entity) { read_result[0] }
  let(:ar_map) { read_result[1] }

  let!(:snapshot1) { take_snapshot }
  let(:snapshot_diff) { EntityMapper::SnapshotDiff::Calculate.new.call(snapshot1, take_snapshot) }

  subject { described_class.call(map, snapshot_diff, order, ar_map) }

  def take_snapshot
    EntityMapper::Snapshot::TakeSnapshot.new.call(mapped_entity, map)
  end

  context "existing order" do
    let(:order_item) do
      ::OrderItem.new(name: "order-item", quantity: 3, price_value: 3, price_currency: "USD")
    end

    let(:order) do
      ::Order.create!(name: "test-name", paid: true).tap do |order|
        order.order_items = [order_item]
      end
    end

    context "order property changed" do
      before do
        mapped_entity.refund!
      end

      it "updates flag in DB" do
        subject
        expect(order.reload.paid).to eq false
      end
    end

    context "order item property changed" do
      before do
        mapped_entity.items.first.quantity = 5
      end

      it "updates flag in DB" do
        subject
        expect(order_item.reload.quantity).to eq 5
      end
    end

    context "order item removed" do
      before do
        mapped_entity.clear!
      end

      it "removes entity from DB" do
        subject
        expect { order_item.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "order item added" do
      before do
        mapped_entity.add_item TestEntities::OrderItem.new("Milk", 1, TestEntities::Price.new(3, TestEntities::Currency.new("PLN")))
      end

      it "adds new item" do
        expect { subject }.to change { order.order_items.count }.from(1).to(2)
      end

      it "saves all properties" do
        subject
        expect(OrderItem.last.attributes).to include(
          "name" => "Milk",
          "price_value" => 3,
          "price_currency" => "PLN",
          "quantity" => 1,
        )
      end
    end

    it "creates tags using custom builder" do
      mapped_entity.tags.push(TestEntities::Tag.new("tag1"))

      expect(subject.reload.tags.count).to eq 1
      expect(subject.reload.tags.first.name).to eq "tag1"
    end
  end

  context "new order" do
    let(:order) { ::Order.new }

    before do
      mapped_entity.name = "Test name"
    end

    it "saves order" do
      expect(subject).to be_persisted
      expect(subject.name).to eq "Test name"
    end

    context "with nested items" do
      before do
        mapped_entity.add_item TestEntities::OrderItem.new("Milk", 1, TestEntities::Price.new(3, TestEntities::Currency.new("PLN")))
      end

      it "saves order" do
        expect(subject).to be_persisted
        expect(subject.name).to eq "Test name"
      end

      it "saves nested item" do
        expect(subject.order_items.count).to eq 1
        expect(subject.order_items.first).to have_attributes(
          name: "Milk", quantity: 1, price_value: 3, price_currency: "PLN"
        )
      end
    end
  end
end
