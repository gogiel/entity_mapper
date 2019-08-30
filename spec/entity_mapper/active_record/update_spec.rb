# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::Update do
  let(:map) { TestMapping }

  def transaction(&block)
    EntityMapper::Transaction.call(&block)
  end

  it "returns last call from transaction" do
    result = transaction do
      5
    end
    expect(result).to eq 5
  end

  it "passes options to the context" do
    context = double :context_class, new: EntityMapper::ActiveRecord::Context.new

    EntityMapper::Transaction.call(context_class: context, a: 1, b: 2) {}

    expect(context).to have_received(:new).with(a: 1, b: 2)
  end

  context "existing order" do
    let(:comment) { OrderItemComment.new content: "No comments." }
    let(:owner) { OrderItemOwner.new name: "John" }

    let(:order_item) do
      ::OrderItem.new(name: "order-item", quantity: 3, price_value: 3, price_currency: "USD").tap do |order_item|
        order_item.comments = [comment]
        order_item.owner = owner
      end
    end

    let(:order) do
      ::Order.create!(name: "test-name", paid: true).tap do |order|
        order.order_items = [order_item]
      end.tap(&:save!)
    end

    context "order property changed" do
      subject do
        transaction do |context|
          mapped_entity = context.read(TestMapping, order)
          mapped_entity.refund!
        end
      end

      it "updates flag in DB" do
        subject
        expect(order.reload.paid).to eq false
      end
    end

    context "order item property changed" do
      subject do
        transaction do |context|
          mapped_entity = context.read(TestMapping, order)
          mapped_entity.items.first.quantity = 5
        end
      end

      it "updates flag in DB" do
        subject
        expect(order_item.reload.quantity).to eq 5
      end
    end

    context "order item removed" do
      subject do
        transaction do |context|
          mapped_entity = context.read(TestMapping, order)
          mapped_entity.clear!
        end
      end

      it "removes entity from DB" do
        subject
        expect { order_item.reload }.to raise_error ActiveRecord::RecordNotFound
      end

      describe "nested relation with default remove strategy" do
        it "removes relation entities from DB" do
          subject
          expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      describe "nested relation with ignore remove strategy" do
        it "doesn't remove relation entities from DB" do
          subject
          expect { owner.reload }.not_to raise_error
        end
      end
    end

    context "order item added" do
      subject do
        transaction do |context|
          mapped_entity = context.read(TestMapping, order)
          mapped_entity.add_item TestEntities::OrderItem.new("Milk", 1, TestEntities::Price.new(3, TestEntities::Currency.new("PLN")))
        end
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
          "state" => "not_completed"
        )
      end
    end

    it "creates tags using custom builder" do
      transaction do |context|
        mapped_entity = context.read(TestMapping, order)
        mapped_entity.tags.push(TestEntities::Tag.new("tag1"))
      end

      expect(order.reload.tags.count).to eq 1
      expect(order.reload.tags.first.name).to eq "tag1"
    end
  end

  context "new order" do
    context "from not persisted AR" do
      let(:order) { ::Order.new }

      before do
        transaction do |context|
          mapped_entity = context.read(TestMapping, order)
          mapped_entity.name = "Test name"
        end
      end

      it "saves order" do
        expect(order).to be_persisted
        expect(order.name).to eq "Test name"
      end

      context "with nested items" do
        before do
          transaction do |context|
            mapped_entity = context.read(TestMapping, order)
            mapped_entity.add_item TestEntities::OrderItem.new("Milk", 1, TestEntities::Price.new(3, TestEntities::Currency.new("PLN")))
          end
        end

        it "saves order" do
          expect(order).to be_persisted
          expect(order.name).to eq "Test name"
        end

        it "saves nested item" do
          expect(order.order_items.count).to eq 1
          expect(order.order_items.first).to have_attributes(
            name: "Milk", quantity: 1, price_value: 3, price_currency: "PLN", state: "not_completed"
          )
        end
      end
    end

    context "from entity object" do
      let(:create_order) do
        transaction do |context|
          order_entity = TestEntities::Order.new "Test name"
          @order = context.create(TestMapping, order_entity, Order)
        end
      end

      it "saves order" do
        expect { create_order }.to change(Order, :count).by(1)
        expect(@order).to eq Order.last
        expect(@order).to be_persisted
        expect(@order.name).to eq "Test name"
      end
    end
  end
end
