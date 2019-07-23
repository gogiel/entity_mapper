# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::Snapshot::TakeSnapshot do
  let(:currency) { TestEntities::Currency.new("USD") }
  let(:price) { TestEntities::Price.new(5, currency) }
  let(:item) { TestEntities::OrderItem.new("Test Item", 2, price) }

  let(:order) do
    TestEntities::Order.new("order-name").tap do |order|
      order.add_item(item)
    end
  end

  let(:map) { TestMapping }

  subject(:snapshot) { described_class.new.call(order, TestMapping) }

  before do
    snapshot
    # Change values to make sure that snapshot has a copy
    order.name = "new-name"
    item.name = "new-item-name"
    item.quantity = 5
    price.value = 1
    currency.name = "PLN"
  end

  it "stores references to the original object" do
    expect(snapshot.object).to eq order
  end

  it "stores object params" do
    name_property = map.property_by_name("name")
    paid_property = map.property_by_name("paid")

    expect(snapshot.properties_map.fetch(name_property)).to eq "order-name"
    expect(snapshot.properties_map.fetch(paid_property)).to eq false
  end

  describe "items relation" do
    let(:items_relation) { map.relation_by_name "items" }
    let(:items_relation_snapshot) { snapshot.relations_map.fetch(items_relation) }
    let(:item_snapshot) { items_relation_snapshot.first }

    it "stores reference to the original object" do
      expect(items_relation_snapshot.size).to eq 1
      expect(item_snapshot.object).to eq item
    end

    it "stores params of nested object" do
      name_property = items_relation.mapping.property_by_name "name"
      quantity_property = items_relation.mapping.property_by_name "quantity"

      expect(item_snapshot.properties_map.fetch(name_property)).to eq "Test Item"
      expect(item_snapshot.properties_map.fetch(quantity_property)).to eq 2
    end

    describe "price relation" do
      let(:price_relation) { items_relation.mapping.relation_by_name("price") }
      let(:price_snapshot) { item_snapshot.relations_map.fetch(price_relation) }

      it "stores reference to the original object" do
        expect(price_snapshot.object).to eq price
      end

      it "stores params of nested object" do
        value_property = price_relation.mapping.property_by_name "value"

        expect(price_snapshot.properties_map.fetch(value_property)).to eq 5
      end

      describe "currency relation" do
        let(:currency_relation) { price_relation.mapping.relation_by_name("currency") }
        let(:currency_snapshot) { price_snapshot.relations_map.fetch(currency_relation) }

        it "stores reference to the original object" do
          expect(currency_snapshot.object).to eq currency
        end

        it "stores params of nested object" do
          name_property = currency_relation.mapping.property_by_name "name"

          expect(currency_snapshot.properties_map.fetch(name_property)).to eq "USD"
        end
      end
    end
  end
end
