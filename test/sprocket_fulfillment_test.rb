require 'test/unit'

class SprocketFulfillmentTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_this_plugin
    @order = SprocketFulfillmentOrder.create(:first_name => "Dan" ,
                                                   :last_name => 'Brown',
                                                   :sales_id =>'ASD',
                                                   :address_1 => "621, Some Lane",
                                                   :city => "Newyork",
                                                   :country => Map.get_country_code("United States"),
                                                   :state =>'NY',
                                                   :zipcode=>'10013',
                                                   :ship_via => Map.get_carrier_code('USPS Express Mail') 
                                                   )

    @order.sprocket_products << SprocketProduct.new(:product => "Da Vinci Code", :quantity => 2, :price => 23.00)

  end
end
