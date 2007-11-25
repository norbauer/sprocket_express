ActiveRecord::Schema.define(:version => 0) do
  create_table :sprocket_express_orders, :force => true do |t|
    t.string :ship_via, :limit => 3
    t.string :billing_last_name, :limit => 20
    t.string :billing_first_name, :limit => 15
    t.string :billing_company, :limit => 40
    t.string :billing_address_1, :limit => 40
    t.string :billing_address_2, :limit => 40
    t.string :billing_city, :limit => 20
    t.string :billing_state, :limit => 3
    t.string :billing_zipcode, :limit => 10
    t.string :billing_phone, :limit => 14
    t.string :billing_email, :limit => 50
    t.string :billing_country, :limit => 3
    t.string :shipping_last_name, :limit => 20
    t.string :shipping_first_name, :limit => 15
    t.string :shipping_company, :limit => 40
    t.string :shipping_address_1, :limit => 40
    t.string :shipping_address_2, :limit => 40
    t.string :shipping_city, :limit => 20
    t.string :shipping_state, :limit => 3
    t.string :shipping_zipcode, :limit => 10
    t.string :shipping_phone, :limit => 14
    t.string :shipping_email, :limit => 50
    t.string :shipping_country, :limit => 3
    t.boolean :shipping_same_as_billing, :default => true
    t.datetime :date_of_original_purchase_transaction
    t.integer :id_from_original_purchase_transaction
    t.datetime :hold_date
    t.decimal :shipping_fee, :precision => 8, :scale => 2
    t.string :gift_message_1, :limit => 70
    t.string :gift_message_2, :limit => 70
    t.string :gift_message_3, :limit => 70
    t.boolean :sent_for_fulfillment, :default => false
    t.timestamps
  end

  create_table :sprocket_express_order_line_items, :force => true do |t|
    t.integer :sprocket_express_order_id
    t.string :sku, :limit => 20
    t.integer :quantity
    t.decimal :price, :precision => 6, :scale => 2
    t.integer :discount_percent
  end
end
