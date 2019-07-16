# frozen_string_literal: true

RSpec.describe EntityMapper do
  describe ".map" do
    it "returns a new model and yields the DSL" do
      internal_spy = spy

      mapping = described_class.map do |dsl|
        internal_spy.dsl(dsl)
        internal_spy.mapping(dsl.mapping)
      end

      expect(mapping).to be_kind_of EntityMapper::Mapping::Model
      expect(internal_spy).to have_received(:dsl).with(kind_of(EntityMapper::Mapping::DSL))
      expect(internal_spy).to have_received(:mapping).with(mapping)
    end
  end
end
