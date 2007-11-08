class CreateSprocketFulfillmentTables < ActiveRecord::Migration
  def self.up
    create_table :sprocket_fulfillment_orders, :force => true do |t|
      t.string :alt_num, :limit => 1, :default => ''
      t.integer :cust_num, :default => 0
      t.string :last_name, :limit => 20
      t.string :first_name, :limit => 15
      t.string :company, :limit => 40
      t.string :address_1, :limit => 40
      t.string :address_2, :limit => 40
      t.string :city, :limit => 20
      t.string :state, :limit => 3
      t.string :zipcode, :limit => 10
      t.boolean :foreign, :default => false
      t.string :phone, :limit => 14
      t.string :comment, :limit => 40
      t.string :ctype_1, :limit => 1
      t.string :ctype_2, :limit => 2
      t.string :ctype_3, :limit => 4
      t.string :tax_exempt, :limit => 1
      t.string :prospect, :limit => 1
      t.string :card_type, :limit => 2
      t.string :card_num, :limit => 19
      t.string :expires, :limit => 5
      t.string :source_key, :limit => 9
      t.string :catalog, :limit => 6
      t.string :sales_id, :limit => 3
      t.string :oper_id, :limit => 3
      t.string :reference, :limit => 10
      t.string :ship_via, :limit => 3
      t.string :fulfilled, :limit => 1
      t.decimal :paid, :precision => 9, :scale => 2
      t.datetime :order_date
      t.integer :odr_num 
      t.string :slast_name, :limit => 20
      t.string :sfirst_name, :limit => 15
      t.string :scompany, :limit => 40
      t.string :saddress_1, :limit => 40
      t.string :saddress_2, :limit => 40
      t.string :scity, :limit => 20
      t.string :sstate, :limit => 3
      t.string :szipcode, :limit => 10
      t.datetime :hold_date
      t.string :pay_method, :limit => 2
      t.decimal :promo_cred, :precision => 8, :scale => 2
      t.string :use_prices, :limit => 1
      t.string :use_ship_amt, :limit => 1
      t.decimal :shipping, :precision => 8, :scale => 2
      t.string :email, :limit => 50
      t.string :country, :limit => 3
      t.string :scountry, :limit => 3
      t.string :phone_2, :limit => 14
      t.string :sphone, :limit => 14
      t.string :sphone_2, :limit => 14
      t.string :semail, :limit => 50
      t.string :order_type, :limit => 6
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