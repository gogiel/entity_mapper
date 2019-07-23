# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::RemoveStrategy::Factory do
  context "when symbol is ignore" do
    it "returns Ignore strategy" do
      result = described_class.find :ignore
      expect(result).to be_kind_of EntityMapper::ActiveRecord::RemoveStrategy::Ignore
    end
  end

  it "returns Destroy strategy by default" do
    result = described_class.find :unknown
    expect(result).to be_kind_of EntityMapper::ActiveRecord::RemoveStrategy::Destroy
  end
end
