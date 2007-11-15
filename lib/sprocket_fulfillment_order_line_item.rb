class SprocketFulfillmentOrderLineItem < ActiveRecord::Base
  belongs_to :sprocket_fulfillment_order
  
  validates_presence_of :sku, :quantity, :price
  validates_length_of :sku, :maximum => 20
end
