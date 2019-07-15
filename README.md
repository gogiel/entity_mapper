# EntityMapper

Entity Mapper gem is inspired by [.NET Entity Framework](https://docs.microsoft.com/en-us/ef/).

It's a persistence/ORM tool that maps data to and from POROs (Plain Old Ruby Objects).

Currently the only supported backend is ActiveRecord.

The gem is under heavy development and not ready for production usage yet. API is very likely to change without any announcements.

## Example

### Setup

Active Record:

```ruby
class Order < ApplicationRecord
  has_many :order_items
end

class OrderItem < ApplicationRecord
  belongs_to :order
end
ActiveRecord::Schema.define do
  create_table "order_items", force: :cascade do |t|
    t.string "name"
    t.integer "price_value"
    t.string "price_currency"
    t.integer "quantity"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.boolean "paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
```

Entities:

```ruby
module Entities
  class Order
    attr_accessor :name

    def initialize(name)
      @name = name
      @items = []
    end

    def refund!
      @paid = false
    end

    def paid?
      @paid
    end

    def items
      @items ||= []
    end
  end
end

module Entities
  class OrderItem
    attr_accessor :name, :quantity, :price

    def initialize(name, quantity, price)
      @name = name
      @quantity = quantity
      @price = price
    end
  end
end

module Entities
  Currency = Struct.new(:name)
end

module Entities
  class Price
    attr_reader :value, :currency

    def initialize(value, currency)
      @value = value
      @currency = currency
    end
  end
end
```

Mapping:

```ruby
Mapping = EntityMapper.map do |m|
  m.model Entities::Order

  m.property(:name)
  m.property(:paid)

  m.has_many("items", persistence_name: "order_items") do |item_model|
    item_model.model Entities::OrderItem
    item_model.property(:quantity)
    item_model.property(:name)

    item_model.has_one("price", persistence_name: nil) do |price_model|
      price_model.model Entities::Price
      price_model.property(:value, :price_value)
      price_model.has_one("currency", persistence_name: nil) do |currency_model|
        currency_model.model Entities::Currency
        currency_model.property(:name, :price_currency, access: :method)
      end
    end
  end
end
```

Sample persisted data:
```ruby
ar_order = ::Order.new(name: "test-name", paid: true)
ar_order.order_items = [::OrderItem.new(name: "order-item", quantity: 3,  price_value: 3, price_currency: "USD")]
ar_order.save!
```


### Reading

```ruby
EntityMapper::Transaction.call do |context|
  mapped_entity = context.read(Mapping, ar_order)
  pp mapped_entity
end
```

Prints (newlines added for visibility):
```
#<TestEntities::Order:0x00007fcd5fdd5520 
  @name="test-name",
  @paid=true,
  @items=[
    #<TestEntities::OrderItem:0x00007fcd60283180
       @quantity=3,
       @name="order-item",
       @price=#<TestEntities::Price:0x00007fcd60282e38 
         @value=3,
         @currency=#<struct TestEntities::Currency name="USD">
       >
    >
  ]
>
```


### Updating

```ruby
EntityMapper::Transaction.call do |context|
  mapped_entity = context.read(Mapping, ar_order)
  
  mapped_entity.items.first.quantity = 5
  mapped_entity.refund!
  mapped_entity.items << TestEntities::OrderItem.new("Milk", 1, TestEntities::Price.new(3, TestEntities::Currency.new("USD")))
end
```

This automatically persists changes. Sample SQL log:
```sql
  OrderItem Update (0.5ms)  UPDATE "order_items" SET "quantity" = ?, "updated_at" = ? WHERE "order_items"."id" = ?  [["quantity", 5], ["updated_at", "2019-07-06 21:25:48.392611"], ["id", 1]]
  OrderItem Create (0.1ms)  INSERT INTO "order_items" ("name", "price_value", "price_currency", "quantity", "order_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?, ?, ?)  [["name", "Milk"], ["price_value", 3], ["price_currency", "USD"], ["quantity", 1], ["order_id", 1], ["created_at", "2019-07-06 21:25:48.396440"], ["updated_at", "2019-07-06 21:25:48.396440"]]
  Order Update (0.1ms)  UPDATE "orders" SET "paid" = ?, "updated_at" = ? WHERE "orders"."id" = ?  [["paid", 0], ["updated_at", "2019-07-06 21:25:48.398639"], ["id", 1]]
```

### Creating

There are two ways to create a new aggregate root:

```ruby
EntityMapper::Transaction.call do |context|
  mapped_entity = Entities::Order.new("New order")
  mapped_entity.items << TestEntities::OrderItem.new("Milk", 1, TestEntities::Price.new(3, TestEntities::Currency.new("USD")))
  context.create(mapped_entity, Order)
end
```

or
```ruby
EntityMapper::Transaction.call do |context|
  mapped_entity = context.read(Mapping, Order.new)
  mapped_entity.name = "New order"
  mapped_entity.items << TestEntities::OrderItem.new("Milk", 1, TestEntities::Price.new(3, TestEntities::Currency.new("USD")))
end
```

This automatically persists new order.

### Removing

```ruby
EntityMapper::Transaction.call do |context|
  mapped_entity = context.read(Mapping, Order.new)

  mapped_entity.items = []
end
```

This removes the `OrderItem` from Order.

## Contributing

Bug reports and pull requests are welcome!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
