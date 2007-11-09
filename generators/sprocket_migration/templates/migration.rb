class CreateSprocketFulfillmentTables < ActiveRecord::Migration
  def self.up
    create_table :sprocket_fulfillment_orders, :force => true do |t|
      t.string :billing_last_name, :limit => 20
      t.string :billing_first_name, :limit => 15
      t.string :billing_company, :limit => 40
      t.string :billig_address_1, :limit => 40
      t.string :billing_address_2, :limit => 40
      t.string :billing_city, :limit => 20
      t.string :billing_state, :limit => 3
      t.string :billing_zipcode, :limit => 10
      t.string :billing_phone, :limit => 14
      t.string :ship_via, :limit => 3
      t.string :shipping_last_name, :limit => 20
      t.string :shipping_first_name, :limit => 15
      t.string :shipping_company, :limit => 40
      t.string :shipping_address_1, :limit => 40
      t.string :shipping_address_2, :limit => 40
      t.string :shipping_city, :limit => 20
      t.string :shipping_state, :limit => 3
      t.string :shipping_zipcode, :limit => 10
      t.datetime :date_of_original_purchase_transaction
      t.integer :id_from_original_purchase_transaction
      t.datetime :hold_date
      t.decimal :shipping_fee, :precision => 8, :scale => 2
      t.string :billing_email, :limit => 50
      t.string :country, :limit => 3
      t.string :scountry, :limit => 3
      t.string :phone_2, :limit => 14
      t.string :shipping_phone, :limit => 14
      t.string :shipping_email, :limit => 50
      t.string :inpart, :limit => 1
      t.string:title, :limit => 40
      t.string :salu, :limit => 6
      t.string :hono, :limit => 6
      t.string :ext, :limit => 5
      t.string :ext2, :limit => 5
      t.string :stitle, :limit => 40
      t.string :ssalu, :limit => 6
      t.string :shono, :limit => 6
      t.string :sext, :limit => 5
      t.string :sext2, :limit => 5
      t.datetime :ship_when
      t.string :password, :limit => 20
      t.string :rcode, :limit => 3
      t.string :approval , :limit => 10
      t.string :avs, :limit => 2
      t.string :antrans_id, :limit => 30
      t.decimal :auth_amt, :precision => 11, :scale => 2
      t.datetime :auth_time
      t.string :internet_id, :limit => 32    
      t.boolean :internet
      t.string :priority, :limit => 1
      t.boolean :no_mail
      t.boolean :no_rent
      t.boolean :no_email
      t.string :po_number, :limit => 15
      t.string :address_3, :limit => 30
      t.string :saddress_3, :limit => 30
      t.string :cc_other, :limit => 4
      t.string :order_promo
      t.string :bestorder_promo
      t.string :order_memo1, :limit => 70
      t.string :order_memo2, :limit => 70
      t.string :order_memo3, :limit => 70
      t.string :ship_ahead    
      t.timestamps
    end

    create_table :sprocket_fulfillment_order_line_items, :force => true do |t|
      t.integer :sprocket_fulfillment_order_id
      t.string :product, :limit => 20
      t.integer :quantity
      t.decimal :price, :precision => 12, :scale => 4
      t.integer :discount
      t.string :greeting, :limit => 35
      t.string :custom
      t.string :order_note
      t.string :fulfill
      t.string :return_product_code
    end

  end

  def self.down
    drop_table :sprocket_fulfillment_orders
    drop_table :sprocket_fulfillment_order_line_items
  end
end