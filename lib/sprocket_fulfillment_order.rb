class SprocketFulfillmentOrder < ActiveRecord::Base
  require 'csv'    
  has_many :sprocket_fulfillment_order_line_items
  validates_presence_of :first_name, :last_name, :sales_id, :address_1, :city, :country, :state, :zipcode
  validates_length_of :alt_num, :first_name, :sfirst_name, :po_number, :maximum => 15, :allow_nil => true
  validates_length_of :last_name, :slast_name, :city, :scity, :password, :maximum => 20, :allow_nil => true
  validates_length_of :company, :address_1, :address_2, :comment, :scompany, :saddress_1, :saddress_2, :title, :stitle, :maximum => 40, :allow_nil => true
  validates_length_of :sales_id, :is => 3

  validates_inclusion_of :country, :scountry, :in => Map::COUNTRY_CODES, :message => "is not valid. Please check country mapping for valid country codes.", :allow_nil => true
  validates_inclusion_of :ship_via, :in => Map::CARRIER_CODES, :message => "is not valid. Please check carrier mapping for valid carrier codes."

  validates_format_of :email, :semail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_nil => true

  validates_inclusion_of :state, :in =>  ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC',
                                          'FM','FL','GA','GU','HI','ID','IL','IN','IA','KS',
                                          'KY','LA','ME','MH','MD','MA','MI','MN','MS','MO',
                                          'MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP',
                                          'OH','OK','OR','PW','PA','PR','RI','SC','SD','TN',
                                          'TX','UT','VT','VI','VA','WA','WV','WI','WY'], 
                                  :if  => Proc.new { |order| order.foreign? == false }, 
                                  :message => 'is not a valid two-character state abbreviation.'

  def validate
    if country == Map.get_country_code('United States') && state.size > 2
      errors.add('state', "is not valid. If shipping in US, please use 2 character state code. ")
    end
    if scountry == Map.get_country_code('United States') && sstate.size > 2
      errors.add('sstate', "is not valid. If shipping in US, please use 2 character state code. ")
    end
  end
  
  # Create a hash with attributes values and corresponding mapping column
  def assign_to_map
    @row = {}
    SprocketFulfillment::Map::MAPPING.each do |m|
      @row["#{m[1]}"] = send(m[0]) if has_attribute?(m[0])
    end
    return @row
  end
  
  # returns the property of an attribute as defined in MAP::MAPPING. 
  def self.show_property(attr)
    Map.search_attribute(attr.to_sym)[2]
  end
  
  def self.create_order_file_for(start_time, end_time= Time.now)
    titles = Map.extract_titles
    r = []
    # Collect all the orders
    # IMPORTANT: Change the condition based on cron requirements
    orders = find(:all, :conditions =>["created_at > ? or created_at < ?", start_time, end_time]) 
    p "** Number of orders = #{orders.size}"
    raise "No new orders in this period" if orders.empty?
    # Take each order and create row(s) hash related to that order and its products. If line items in an order are less than 5 it will create single row.
    # If its more than 5 it will create the first row and put continued=X in that row and add remaining items in next row.
    order_row = 0
    orders.each do |order|
       # Assigning the order related values in the row. Next we will add the products related value for the corresponding order.
        r[order_row] = order.assign_to_map
        products = order.sprocket_fulfillment_order_line_items # collect products
        p "**Products in numbers for order id #{order.id} = #{products.size}"
        i = 1 #product counter
        products.each do |product|
          row_no = order_row +(i-1)/5       # row number depends on number of products. For 1st 5 products... row is 1 or next 5 its 2nd and so on
          j = i%5==0 ? 5 : i%5      # this is number of line item in that row
          
          if i > 5
            r[row_no -1]["Continued"] = "X"
          end
          # Entering product related data in the order's row or in other rows in case of more than 5 products.
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
        order_row  +=1
    end
    
    # enter prepared rows in CSV
    filename = File.join( Map::CSV_STORAGE_PATH, "Order_#{start_time.strftime('%d-%m-%Y')}_#{end_time.strftime('%d-%m-%Y')}.csv")

    CSV.open(filename, 'w') do |writer|
      #first row as titles of fields
         writer << titles   
      # now add orders rows from hash based on titles as keys.  
         r.each do |row|
           ary = []
           titles.each{|val| ary << row[val] || ''}
           writer << ary
         end
    end
    
    return filename
  end
  
end
