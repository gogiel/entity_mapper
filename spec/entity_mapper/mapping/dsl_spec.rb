# typed: false
# frozen_string_literal: true

RSpec.describe EntityMapper::Mapping::DSL do
  let(:mapping) { EntityMapper::Mapping::Model.new }

  subject(:dsl) { described_class.new(mapping) }

  it "updates mapping" do
    dsl.model "fake-model"
    dsl.remove_strategy "fake-remove-strategy"

    dsl.property "property1", "property1-persistence_name", test: "property1-options"
    dsl.property "property2", test: "property2-options"

    dsl.has_one "has_one_relation", persistence_name: "has_one-persistence_name", test: "has_one_relation" do |inner_dsl|
      inner_dsl.model "inner-has_one"
      inner_dsl.has_one "has_one_inner", persistence_name: "has_one_inner-persistence_name" do |nested|
        nested.model "inner-nested-model"
      end
    end

    dsl.has_one_virtual "has_one_virtual", test: "has_one_virtual" do |inner_dsl|
      inner_dsl.model "inner_has_one_virtual"
    end

    dsl.has_many "has_many_relation", persistence_name: "has_many-persistence_name", test: "has_many_relation" do |inner_dsl|
      inner_dsl.model "inner_has_many_relation"
    end

    expect(mapping.model_class).to eq "fake-model"
    expect(mapping.remove_strategy).to eq "fake-remove-strategy"

    expect(mapping.properties.to_a[0].name).to eq "property1"
    expect(mapping.properties.to_a[0].persistence_name).to eq "property1-persistence_name"
    expect(mapping.properties.to_a[0].options).to eq test: "property1-options"

    expect(mapping.properties.to_a[1].name).to eq "property2"
    expect(mapping.properties.to_a[1].persistence_name).to eq "property2"
    expect(mapping.properties.to_a[1].options).to eq test: "property2-options"

    has_one_relation = mapping.relations.to_a[0]
    expect(has_one_relation).to be_kind_of(EntityMapper::Mapping::HasOneRelation)
    expect(has_one_relation.name).to eq "has_one_relation"
    expect(has_one_relation.persistence_name).to eq "has_one-persistence_name"
    expect(has_one_relation.options).to eq test: "has_one_relation"

    has_one_inner_mapping = has_one_relation.mapping
    expect(has_one_inner_mapping.model_class).to eq "inner-has_one"
    nested_has_one_relation = has_one_inner_mapping.relations.to_a[0]
    expect(nested_has_one_relation.name).to eq "has_one_inner"
    expect(nested_has_one_relation.persistence_name).to eq "has_one_inner-persistence_name"
    expect(nested_has_one_relation.options).to eq({})
    expect(nested_has_one_relation.mapping.model_class).to eq "inner-nested-model"

    has_one_virtual_relation = mapping.relations.to_a[1]
    expect(has_one_virtual_relation).to be_kind_of(EntityMapper::Mapping::HasOneVirtualRelation)
    expect(has_one_virtual_relation.name).to eq "has_one_virtual"
    expect(has_one_virtual_relation.options).to eq test: "has_one_virtual"
    expect(has_one_virtual_relation.mapping.model_class).to eq "inner_has_one_virtual"

    has_many_relation = mapping.relations.to_a[2]
    expect(has_many_relation).to be_kind_of(EntityMapper::Mapping::HasManyRelation)
    expect(has_many_relation.name).to eq "has_many_relation"
    expect(has_many_relation.persistence_name).to eq "has_many-persistence_name"
    expect(has_many_relation.options).to eq test: "has_many_relation"
    expect(has_many_relation.mapping.model_class).to eq "inner_has_many_relation"
  end
end
