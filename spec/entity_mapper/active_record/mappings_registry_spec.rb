# frozen_string_literal: true

RSpec.describe EntityMapper::ActiveRecord::MappingsRegistry do
  let(:registry) { described_class.new }

  let(:entity_class) { Class.new }
  let(:ar_class1) { Class.new }
  let(:map1) { EntityMapper::Mapping::Model.new.tap { |m| m.model_class = entity_class } }
  let(:ar_class2) { Class.new }
  let(:map2) { EntityMapper::Mapping::Model.new }

  let(:entity) { entity_class.new }

  before do
    registry.register ar_class1, map1
    registry.register ar_class2, map2
  end

  describe "#read" do
    context "when not registered object is provided" do
      let(:ar_object) { Object.new }
      it "raises error when class is not detected" do
        expect { registry.read(ar_object) }.
          to raise_error "Object class record not registered."
      end
    end

    context "when registered object is used" do
      let(:ar_object) { ar_class1.new }
      let(:context) do
        instance_double EntityMapper::ActiveRecord::Context
      end

      context "when context is set" do
        before do
          allow(context).to receive(:read).with(map1, ar_object) { entity }
        end

        it "yields read entity" do
          expect { |b| registry.read(ar_object, context: context, &b) }.to yield_with_args(entity)
        end

        it "returns read entity" do
          expect(registry.read(ar_object, context: context)).to eq entity
        end

        context "when object is a derivative of a registered class" do
          let(:ar_class1_derivative) { Class.new(ar_class1) }
          let(:ar_object) { ar_class1_derivative.new }

          it "returns read entity" do
            expect(registry.read(ar_object, context: context)).to eq entity
          end

          it "returns more precise mapping" do
            registry.register(ar_class1_derivative, map2)
            entity2 = double
            allow(context).to receive(:read).with(map2, ar_object) { entity2 }
            expect(registry.read(ar_object, context: context)).to eq entity2
          end
        end
      end

      context "when context is not set" do
        let(:instantaneous_context) { instance_double EntityMapper::ActiveRecord::Context }

        before do
          allow(EntityMapper::Transaction).to receive(:call).and_yield(instantaneous_context)
          allow(instantaneous_context).to receive(:read).with(map1, ar_object) { entity }
        end

        it "yields read entity from instantaneous context" do
          expect { |b| registry.read(ar_object, &b) }.to yield_with_args(entity)
        end

        it "returns read entity from instantaneous context" do
          expect(registry.read(ar_object)).to eq entity
        end
      end
    end
  end

  describe "#create" do
    context "when entity is not registered" do
      it "raises error" do
        expect { registry.create(Object.new) }.
          to raise_error "Object entity not registered"
      end
    end

    context "when the same entity is registered for two records" do
      let(:ar_class3) { Class.new }

      before do
        registry.register ar_class3, map1
      end

      it "raises error" do
        expect { registry.create(entity) }.
          to raise_error "Ambiguous mapping for #{entity_class}"
      end
    end

    context "when entity is registered for only one AR record" do
      let(:ar_record) { ar_class1.new }

      context "when context is set" do
        let(:context) { instance_double EntityMapper::ActiveRecord::Context }
        before do
          allow(context).to receive(:create).with(map1, entity, ar_class1) { ar_record }
        end

        it "creates record from provided context " do
          registry.create(entity, context: context)
          expect(context).to have_received(:create).with(map1, entity, ar_class1)
        end

        it "returns active record object" do
          expect(registry.create(entity, context: context)).to eq ar_record
        end

        it "yield active record object" do
          expect { |b| registry.create(entity, context: context, &b) }.to yield_with_args(ar_record)
        end
      end

      context "when context is not set" do
        let(:instantaneous_context) { instance_double EntityMapper::ActiveRecord::Context }
        before do
          allow(EntityMapper::Transaction).to receive(:call).and_yield(instantaneous_context)
          allow(instantaneous_context).to receive(:create).with(map1, entity, ar_class1) { ar_record }
        end

        it "creates record from provided context " do
          registry.create(entity)
          expect(instantaneous_context).to have_received(:create).with(map1, entity, ar_class1)
        end

        it "returns active record object" do
          expect(registry.create(entity)).to eq ar_record
        end

        it "yield active record object" do
          expect { |b| registry.create(entity, &b) }.to yield_with_args(ar_record)
        end
      end
    end
  end
end
