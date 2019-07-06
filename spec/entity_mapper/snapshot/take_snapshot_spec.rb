RSpec.describe EntityMapper::Snapshot::TakeSnapshot do
  let(:order) do
    TestEntities::Order.new.tap do |order|
      price = TestEntities::Price.new(5, TestEntities::Currency.new("USD"))
      order.add_item(TestEntities::OrderItem.new("Test Item", 2, price))
    end
  end

  let(:map) { TestMapping }

  subject(:snapshot) { described_class.new.call(order, map)}

  it "creates valid snapshot" do
    snapshot
    # TODO - validate
  end
end
