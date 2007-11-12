create_table :sprocket_fulfillment_order_line_items, :force => true do |t|
  t.integer :sprocket_fulfillment_order_id
  t.string :sku, :limit => 20
  t.integer :quantity
  t.decimal :price, :precision => 12, :scale => 4
  t.integer :discount
end