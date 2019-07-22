# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::ArMap do
  subject { described_class.new }

  it "returns saved object" do
    object = double
    ar_model = double
    subject[object] = ar_model
    expect(subject[object]).to eq ar_model
  end

  it "returns nil if saved object is not present" do
    object = double
    expect(subject[object]).to be_nil
  end
end
