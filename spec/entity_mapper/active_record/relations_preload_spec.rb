# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::RelationsPreload do
  let(:relations_to_preload) { described_class.call(TestMapping) }

  it "returns a list of nested associations to preload" do
    expect(relations_to_preload).to eq(
      ["customer", { "order_items" => %w[comments owner discount] }, "tags"]
    )
  end
end
