# frozen_string_literal: true

RSpec.describe "basic mapping reading" do
  let(:map) { TestMapping }

  let(:order_item) do
    ::OrderItem.new(name: "order-item", quantity: 3,  price_value: 3, price_currency: "USD")
  end

  let(:order) do
    ::Order.new(name: "test-name", paid: true).tap do |order|
      order.order_items = [order_item]
    end
  end

  subject(:result) { EntityMapper::ActiveRecord::Read.call(map, order) }
  let(:mapped_entity) { result[0] }

  it "reads root object" do
    expect(mapped_entity.name).to eq "test-name"
    expect(mapped_entity).to be_paid
  end

  it "reads has_many relation" do
    expect(mapped_entity.items.count).to eq 1
    item = mapped_entity.items.first
    expect(item.name).to eq "order-item"
    expect(item.quantity).to eq 3
    expect(item.price.value).to eq 3
    expect(item.price.currency).to eq TestEntities::Currency.new("USD")
  end
end
