require File.dirname(__FILE__) + '/spec_helper'
require 'sprocket_data_push'

describe "An exported CSV version of a fulfillment order with fewer than five SKUs to ship" do
  
  before do
    SprocketFulfillmentOrder.destroy_all
    @order = SprocketFulfillmentOrder.new(valid_order_attributes)
    @order.save!
    7.times do |n|
      @order.sprocket_fulfillment_order_line_items << SprocketFulfillmentOrderLineItem.new(valid_line_item_attributes.with(:sku => "00#{n}"))
    end
  end

  it 'should match the format specified by Sprocket Express' do
    @push = SprocketDataPush.new(:customer_id => 'NOR',
                                 :start_time => Time.now-1.days,
                                 :output_file_directory_path => '/Users/ryan/Desktop')
    @push.write_csv!
    1.should eql(1)
  end

end