class CreateSprocketFulfillmentTables < ActiveRecord::Migration
  def self.up
    # To keep things DRY wth schema.rb for running specs
    eval File.open(File.dirname(__FILE__) + '/_sprocket_fulfillment_orders.rb').read
    eval File.open(File.dirname(__FILE__) + '/_sprocket_fulfillment_order_line_items.rb').read
  end

  def self.down
    drop_table :sprocket_fulfillment_orders
    drop_table :sprocket_fulfillment_order_line_items
  end
end