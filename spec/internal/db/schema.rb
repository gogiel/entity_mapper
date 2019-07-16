# frozen_string_literal: true

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

  create_table "order_item_comments", force: :cascade do |t|
    t.integer "order_item_id"
    t.string "content"
  end

  create_table "order_item_discounts", force: :cascade do |t|
    t.integer "order_item_id"
    t.integer "value"
  end

  create_table "order_item_owners", force: :cascade do |t|
    t.integer "order_item_id"
    t.string "name"
  end

  create_table "order_tags", force: :cascade do |t|
    t.integer "order_id"
    t.integer "tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end
end
