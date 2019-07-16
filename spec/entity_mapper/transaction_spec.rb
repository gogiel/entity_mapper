# frozen_string_literal: true

RSpec.describe EntityMapper::Transaction do
  describe ".call" do
    describe "custom context" do
      let(:context_instance) { instance_double EntityMapper::ActiveRecord::Context, read: nil }
      let(:context_class) { double new: context_instance }

      let(:call_dsl) do
        described_class.call(context_class: context_class, a: 1, b: 2) do |context|
          expect(context).to be_kind_of(EntityMapper::Transaction::ContextDSL)
          context.read(:fake_mapping, :fake_object)
        end
      end

      before do
        allow(context_instance).to receive(:call).and_yield(context_instance)
      end

      it "passes options to context constructor" do
        call_dsl
        expect(context_class).to have_received(:new).with(a: 1, b: 2)
      end

      it "yields context wrapped in a DSL" do
        call_dsl
        expect(context_instance).to have_received(:read).with(:fake_mapping, :fake_object)
      end
    end

    describe "default context" do
      let(:context_instance) { instance_double EntityMapper::ActiveRecord::Context, read: nil }

      let(:call_dsl) do
        described_class.call(a: 1, b: 2) do |context|
          expect(context).to be_kind_of(EntityMapper::Transaction::ContextDSL)
          context.read(:fake_mapping, :fake_object)
        end
      end

      before do
        allow(EntityMapper::ActiveRecord::Context).to receive(:new).and_return(context_instance)
        allow(context_instance).to receive(:call).and_yield(context_instance)
      end

      it "passes options to context constructor" do
        call_dsl
        expect(EntityMapper::ActiveRecord::Context).to have_received(:new).with(a: 1, b: 2)
      end

      it "yields context wrapped in a DSL" do
        call_dsl
        expect(context_instance).to have_received(:read).with(:fake_mapping, :fake_object)
      end
    end
  end
end
