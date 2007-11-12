ActiveRecord::Schema.define(:version => 0) do
  # To keep things DRY wth migration.rb
  eval File.open(File.dirname(__FILE__) + '/../../generators/sprocket_migration/templates/_sprocket_fulfillment_orders.rb').read
  eval File.open(File.dirname(__FILE__) + '/../../generators/sprocket_migration/templates/_sprocket_fulfillment_order_line_items.rb').read
end
