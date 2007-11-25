require File.dirname(__FILE__) + '/spec_helper'
require 'sprocket_data_push'
require 'fileutils'

describe "An exported CSV version of a fulfillment order with more than five SKUs to ship" do
  
  before do
    SprocketFulfillmentOrder.destroy_all
    @order = SprocketFulfillmentOrder.new(valid_order_attributes)
    @order.save!
    7.times do |n|
      @order.sprocket_fulfillment_order_line_items << SprocketFulfillmentOrderLineItem.new(valid_line_item_attributes.with(:sku => "00#{n}"))
    end
  end

  it 'should have transformed the data properly into the format specified by SprocketExpress' do
    @push = SprocketDataPush.new(:customer_id => 'NOR')
    
    rows, orders = @push.create_csv
        
    expected_first_line  = "AltNum,Cust_Num,LastName,FirstName,Company,Address1,Address2,City,State,ZipCode,Foreign,Phone,Comment,Ctype1,Ctype2,Ctype3,TaxExempt,Prospect,CardType,CardNum,Expires,Source_Key,Catalog,Sales_ID,Oper_ID,Reference,Ship_Via,Fulfilled,Paid,Continued,Order_Date,Ord-Num,Product01,Quantity01,Product02,Quantity02,Product03,Quantity03,Product04,Quantity04,Product05,Quantity05,SLastName,SFirstName,SCompany,SAddress1,SAddress2,SCity,SState,SZipCode,HoldDate,Greeting1,Greeting2,PromoCred,UsePrices,Price01,Discount01,Price02,Discount02,Price03,Discount03,Price04,Discount04,Price05,Discount05,UseShipAmt,Shipping,Email,Country,Scountry,Phone2,Sphone,Sphone2,Semail,OrderType,Inpart,Title,Salu,Hono,Ext,Ext2,STitle,Ssalu,Shono,sext,sext2,Ship_When,Greeting3,Greeting4,Greeting5,Greeting6,Password,Custom01,Custom02,Custom03,Custom04,Custom05,Rcode,Approval,Avs,AnTrans_ID,Auth_Amt,Auth_Time,InternetID,Ordnote1,Ordnote2,Ordnote3,Ordnote4,Ordnote5,Fulfill1,Fulfill2,Fulfill3,Fulfill4,Fulfill5,Internet,Priority,NoMail,NoRent,NoEmail,PONumber,Address3,SAddress3,CC_Other,OrderPromo,BestOrderPromo,OrderMemo1,OrderMemo2,OrderMemo3,ShipAhead,ReturnProductCode1,ReturnProductCode2,ReturnProductCode3,ReturnProductCode4,ReturnProductCode5\n"
    expected_second_line = ',"0","Richard","Dawkins","Oxford University","Bodleian Library","Floor 1","Oxford",,"OX1 3BG","Y",,,,,,,,,,,"NOR",,"NOR",,,"PM",,,,"04/28/07",4337,"NOR000",37,"NOR001",37,"NOR002",37,"NOR003",37,"NOR004",37,,,,,,,,,,,,,"X",99.99,43,99.99,43,99.99,43,99.99,43,99.99,43,"X",,"e@e.com","073",,,,,,"IMPORT",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"F",,"F","F","F",,,,,,"F",,,,"F",,,,,' + "\n"
    expected_third_line  = ',,,,,,,,,,,,,,,,,,,,,,,,,,,,,"X",,,"NOR005",37,"NOR006",37,,,,,,,,,,,,,,,,,,,,99.99,43,99.99,43,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,' + "\n"
    rows.length.should == 3
    rows[0].should == expected_first_line
    rows[1].should == expected_second_line
    rows[2].should == expected_third_line
  end
  
  it 'should write the CSV file onto the remote FTP server' do
    # @TODO mock this bitch.
    @push = SprocketDataPush.new(:customer_id => 'NOR', :ftp_username => 'test', :ftp_password => 'test')
    @push.deliver!
  end
  
  it 'should mark sent orders as sent'
  
  
end