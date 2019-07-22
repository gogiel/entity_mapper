# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::RemoveStrategy::Destroy do
  it "calls destroy on ar_object" do
    ar_object = spy
    described_class.new.call(ar_object)
    expect(ar_object).to have_received(:destroy)
  end
end
