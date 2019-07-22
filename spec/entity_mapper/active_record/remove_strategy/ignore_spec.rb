# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::RemoveStrategy::Ignore do
  it "does nothing" do
    described_class.new.call(double)
  end
end
