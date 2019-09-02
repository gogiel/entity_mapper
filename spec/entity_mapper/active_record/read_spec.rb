# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::Read do
  let(:map) { TestMapping }

  let(:order_item) do
    ::OrderItem.new(name: "order-item", quantity: 3, price_value: 3, price_currency: "USD",
                    owner: ::OrderItemOwner.new(name: "John"), state: "completed")
  end

  let(:order_item2) do
    ::OrderItem.new(name: "order-item", quantity: 3, price_value: 3, price_currency: "USD",
                    owner: ::OrderItemOwner.new(name: "Mike", admin: true))
  end

  let(:order) do
    ::Order.new(name: "test-name", paid: true).tap do |order|
      order.order_items = [order_item, order_item2]
    end
  end

  subject(:result) { EntityMapper::ActiveRecord::Read.call(map, order) }
  let(:mapped_entity) { result[0] }
  let(:ar_map) { result[1] }

  it "reads root object" do
    expect(mapped_entity.name).to eq "test-name"
    expect(mapped_entity).to be_paid
  end

  it "reads has_many relation" do
    expect(mapped_entity.items.count).to eq 2
    item = mapped_entity.items.first
    expect(item.name).to eq "order-item"
    expect(item.quantity).to eq 3
    expect(item.price.value).to eq 3
    expect(item.price.currency).to eq TestEntities::Currency.new("USD")
    expect(item.owner.first_name).to eq "John"
    expect(item.ready).to eq true
  end

  it "creates model based on model callback" do
    expect(mapped_entity.items[0].owner).to be_kind_of(TestEntities::Owner)
    expect(mapped_entity.items[1].owner).to be_kind_of(TestEntities::Owner::Admin)
  end

  it "returns valid AR map" do
    expect(ar_map[mapped_entity]).to eq order
    expect(ar_map[mapped_entity.items.first]).to eq order_item
  end

  describe "preloading" do
    subject(:load_aggregate) { EntityMapper::ActiveRecord::Read.call(map, Order.find(order.id), preload: preloading_enabled) }

    before do
      order.order_items += 3.times.map do
        ::OrderItem.new(name: "order-item", quantity: 3, price_value: 3, price_currency: "USD",
                        owner: ::OrderItemOwner.new(name: "Mike", admin: true))
      end
      order.save!
    end

    context "when preloading is enabled" do
      let(:preloading_enabled) { true }

      it "preloads associations" do
        queries_count = QueryCounter.call { load_aggregate }
        expect(queries_count).to eq 6
      end
    end

    context "when preloading is disabled" do
      let(:preloading_enabled) { false }

      it "doesn't preload associations" do
        queries_count = QueryCounter.call { load_aggregate }
        expect(queries_count).to eq 18
      end
    end

    context "by default" do
      subject(:load_aggregate) { EntityMapper::ActiveRecord::Read.call(map, Order.find(order.id)) }

      it "preloads associations" do
        queries_count = QueryCounter.call { load_aggregate }
        expect(queries_count).to eq 6
      end
    end
  end
end
