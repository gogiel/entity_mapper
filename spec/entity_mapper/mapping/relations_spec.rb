# typed: false
# frozen_string_literal: true

options = { fake: :options }

RSpec.describe EntityMapper::Mapping::Relation do
  subject { described_class.new("name", "persistence_name", "mapping", options) }

  it_behaves_like "relation", name: "name", persistence_name: "persistence_name", mapping: "mapping", options: options
end

RSpec.describe EntityMapper::Mapping::HasOneRelation do
  subject { described_class.new("name", "persistence_name", "mapping", options) }

  it_behaves_like "relation", name: "name", persistence_name: "persistence_name", mapping: "mapping", options: options
end

RSpec.describe EntityMapper::Mapping::HasManyRelation do
  subject { described_class.new("name", "persistence_name", "mapping", options) }

  it_behaves_like "relation", collection: true, name: "name", persistence_name: "persistence_name", mapping: "mapping", options: options
end

RSpec.describe EntityMapper::Mapping::HasOneVirtualRelation do
  subject { described_class.new("name", "mapping", options) }

  it_behaves_like "relation", virtual: true, name: "name", persistence_name: nil, mapping: "mapping", options: options
end
