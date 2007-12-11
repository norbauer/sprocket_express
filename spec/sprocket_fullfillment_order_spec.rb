require File.dirname(__FILE__) + '/spec_helper'

describe 'A new', SprocketExpressOrder, '(in general)' do
  
  before(:each) do 
    @order = SprocketExpressOrder.new
  end
  
  it 'should default to having shipping the same as the billing address' do
    @order.shipping_same_as_billing?.should eql(true)
  end
  
  it 'should default to a non-foreign (domestic) order' do
    @order.foreign?.should eql(false)
  end
  
end

describe 'A new', SprocketExpressOrder, 'when given acceptable values for the following attributes (and nothing more): ship_via, billing_last_name, billing_first_name, billing_company, billing_address_1, billing_address_2, billing_city, billing_state, billing_zipcode, billing_phone, billing_email, billing_country, date_of_original_purchase_transaction, id_from_original_purchase_transaction and shipping_same_as_billing set to true' do
  
  before(:each) do 
    @order = SprocketExpressOrder.new(valid_order_attributes)
  end

  it 'should be valid' do
    @order.should be_valid
  end
  
  it 'before validating, should truncate billing_first_name, shipping_first_name, billing_last_name, shipping_last_name, billing_company, and shipping_company if those attributes are over the allowed lengths' do
    { :billing_first_name => 15,
      :shipping_first_name => 15,
      :billing_last_name => 20,
      :shipping_last_name => 20,
      :billing_company => 40,
      :shipping_company => 40 }.each_pair do |attribute,limit|
        @order.send("#{attribute.to_s}=", 'x' * (limit+1))
      end
  end

  { :billing_first_name => 15,
    :shipping_first_name => 15,
    :billing_last_name => 20,
    :shipping_last_name => 20,
    :billing_company => 40,
    :shipping_company => 40 }.each_pair do |attribute,limit|
      it "it should truncate the #{attribute} attribute if that value supplied is over the allowable limit" do
        @order.send("#{attribute.to_s}=", 'x' * (limit+1))
        @order.stubs(:'shipping_same_as_billing?').returns(false)
        @order.valid?
        @order.send(attribute).length.should <= limit 
      end
  end
  
  
end

describe 'A new', SprocketExpressOrder, 'when any one of the following attributes are missing: billing_first_name, billing_last_name, billing_address_1, billing_city, billing_country, billing_state, billing_zipcode, ship_via' do

  it 'should be invalid' do
    [:billing_first_name, :billing_last_name, :billing_address_1, :billing_city, :billing_country, :billing_zipcode, :ship_via].each do |attribute|
      @order = SprocketExpressOrder.new(valid_order_attributes.except(attribute))
      @order.should_not be_valid
    end
  end  

end


describe 'A', SprocketExpressOrder, 'with shipping_same_as_billing set to true but values specified for shipping' do
  
  before(:each) do 
    @order = SprocketExpressOrder.new(valid_order_attributes)
  end
    
  it 'should remove those values before saving' do
    [ "shipping_last_name", "shipping_first_name", "shipping_company", "shipping_address_1", "shipping_address_2",
      "shipping_city", "shipping_state", "shipping_zipcode", "shipping_phone", "shipping_email", "shipping_country" ].each do |attribute|
      @order.send("#{attribute}=",'face')
    end
    @order.save!
    [ "shipping_last_name", "shipping_first_name", "shipping_company", "shipping_address_1", "shipping_address_2",
      "shipping_city", "shipping_state", "shipping_zipcode", "shipping_phone", "shipping_email", "shipping_country" ].each do |attribute|
      @order.send("#{attribute}").should eql(nil)
    end

  end
  
end
