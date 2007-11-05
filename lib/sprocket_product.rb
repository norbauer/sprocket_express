class SprocketProduct < ActiveRecord::Base
  belongs_to :sprocket_fulfillment_order
  
  validates_presence_of :product, :quantity, :price
  validates_length_of :product, :maximum =>20,:allow_nil => true
  validates_length_of :greeting, :maximum =>35,:allow_nil => true
  validates_length_of :custom, :order_note, :fulfill, :return_product_code, :maximum =>240,:allow_nil => true
end
