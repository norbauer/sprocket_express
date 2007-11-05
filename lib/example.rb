# Setup steps:
# 1. Create a new migration . 
# 2. Copy the content of create_sprocket_tables.rb file to that migration.
# 3. Create new order as defined below. and add sprocket_products to this order

# Usage. 
# You can assign any of the attributes defiend in SprocketFulfillment::Map::MAPPING
@order = SprocketFulfillmentOrder.create(:first_name => "Dan" ,
                                                   :last_name => 'Brown',
                                                   :sales_id =>'ASD',
                                                   :address_1 => "621, Some Lane",
                                                   :city => "Newyork",
                                                   :country => SprocketFulfillment::Map.get_country_code("United States"),
                                                   :state =>'NY',
                                                   :zipcode=>'10013',
                                                   :ship_via => SprocketFulfillment::Map.get_carrier_code('USPS Express Mail') 
                                                   )

@order.sprocket_products << SprocketProduct.new(:product => "Da Vinci Code", :quantity => 2, :price => 23.00)

# 4. Create CSV file by calling create_order_file_for on SprocketfulfillmentOrder class with arguments like start_time and end_time.
# eg. filename = SprocketFulfillmentOrder.create_order_file_for(Time.now.yesterday)
# filename is the location of newly generated file