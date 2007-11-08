class SprocketFulfillmentOrder < ActiveRecord::Base
  require 'csv'    
  has_many :sprocket_fulfillment_order_line_items
  validates_presence_of :first_name, :last_name, :sales_id, :address_1, :city, :country, :state, :zipcode
  validates_length_of :alt_num, :first_name, :sfirst_name, :po_number, :maximum => 15, :allow_nil => true
  validates_length_of :last_name, :slast_name, :city, :scity, :password, :maximum => 20, :allow_nil => true
  validates_length_of :company, :address_1, :address_2, :comment, :scompany, :saddress_1, :saddress_2, :title, :stitle, :maximum => 40, :allow_nil => true
  validates_length_of :sales_id, :is => 3
  validates_inclusion_of :country, :scountry, :in => ::Map::COUNTRY_CODES, :message => "is not valid. Please check country mapping for valid country codes.", :allow_nil => true
  validates_inclusion_of :ship_via, :in => SprocketFulfillmentOrder::::Map::CARRIER_CODES, :message => "is not valid. Please check carrier mapping for valid carrier codes."
  validates_format_of :email, :semail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_nil => true

  def validate
    if country == ::Map.get_country_code('United States') && state.size > 2
      errors.add('state', "is not valid. If shipping in US, please use 2 character state code. ")
    end
    if scountry == ::Map.get_country_code('United States') && sstate.size > 2
      errors.add('sstate', "is not valid. If shipping in US, please use 2 character state code. ")
    end
  end
  
  # Create a hash with attributes values and corresponding mapping column
  def assign_to_map
    @row = {}
    ::::Map::MAPPING.each do |m|
      @row["#{m[1]}"] = send(m[0]) if has_attribute?(m[0])
    end
    return @row
  end
  
  # returns the property of an attribute as defined in MAP::MAPPING. 
  def self.show_property(attr)
    ::::Map.search_attribute(attr.to_sym)[2]
  end
  
  def self.create_order_file_for(start_time, end_time= Time.now)
    titles = ::Map.extract_titles
    r = []
    # Collect all the orders
    # IMPORTANT: Change the condition based on cron requirements
    orders = find(:all, :conditions =>["created_at > ? or created_at < ?", start_time, end_time]) 
    p "** Number of orders = #{orders.size}"
    raise "No new orders in this period" if orders.empty?
    r[0] = orders[0].assign_to_map
    orders.each do |order|
        products = order.sprocket_fulfillment_order_line_items # collect products
        p "**Products in numbers for order id #{order.id} = #{products.size}"
        i = 1 #product counter
        products.each do |product|
          row_no = i/5
          j = i%5
          if i > 5
            r[row_no -1]["Continued"] = "X"
          end
          r[row_no] ||= {}
          r[row_no]["Product0#{j}"]          = order.sales_id + product.product
          r[row_no]["Quantity0#{j}"]         = product.quantity
          r[row_no]["Price0#{j}"]            = product.price
          r[row_no]["Discount0#{j}"]         = product.discount
          r[row_no]["Greeting#{j}"]          = product.greeting
          r[row_no]["Custom0#{j}"]           = product.custom
          r[row_no]["OrdNote#{j}"]           = product.order_note
          r[row_no]["Fulfill#{j}"]           = product.fulfill
          r[row_no]["ReturnProductCode#{j}"] = product.return_product_code
          i +=1
        end
    end
    
    filename = File.join(RAILS_ROOT, ::Map::CSV_STORAGE_PATH, "Order_#{start_time.strftime('%d-%m-%Y')}_#{end_time.strftime('%d-%m-%Y')}.csv")
    CSV.open(filename, 'w') do |writer|
         writer << titles          
         r.each do |row|
           ary = []
           titles.each{|val| ary << row[val] || ''}
           writer << ary
         end
    end
    
    return filename
  end
  
end
