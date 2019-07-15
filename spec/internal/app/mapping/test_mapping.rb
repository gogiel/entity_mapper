# frozen_string_literal: true

require_relative "test_entities/currency"
require_relative "test_entities/order"
require_relative "test_entities/order_item"
require_relative "test_entities/price"
require_relative "test_entities/tag"

TestMapping = EntityMapper.map do |m|
  m.model TestEntities::Order

  m.property(:name)
  m.property(:paid)

  m.has_many("items", persistence_name: "order_items") do |item_model|
    item_model.model TestEntities::OrderItem
    item_model.property(:quantity)
    item_model.property(:name)

    item_model.has_many("comments", persistence_name: "comments") do |item_comment|
      item_comment.model TestEntities::OrderItemComment
      item_comment.property(:content)
    end

    item_model.has_one("owner", persistence_name: "owner") do |owner|
      owner.remove_strategy :ignore
      owner.model TestEntities::Owner
      owner.property :name
    end

    item_model.has_one("price", persistence_name: nil) do |price_model|
      price_model.model TestEntities::Price
      price_model.property(:value, :price_value)
      price_model.has_one("currency", persistence_name: nil) do |currency_model|
        currency_model.model TestEntities::Currency
        currency_model.property(:name, :price_currency, access: :method)
      end
    end
  end

  find_or_initialize_tag_strategy = lambda do |_relation, parent_ar_object, relation_item_diff_snapshot|
    tag_name = relation_item_diff_snapshot.object.name
    Tag.find_or_initialize_by(name: tag_name).tap do |tag|
      parent_ar_object.order_tags.new(tag: tag)
    end
  end

  m.has_many("tags", persistence_name: "tags", build_strategy: find_or_initialize_tag_strategy) do |tag_model|
    tag_model.model TestEntities::Tag
    tag_model.property(:name)
  end
end
