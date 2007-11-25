class SprocketExpressOrderLineItem < ActiveRecord::Base
  belongs_to :sprocket_express_order
  
  validates_presence_of :sku, :quantity, :price
  validates_length_of :sku, :maximum => 20
end
