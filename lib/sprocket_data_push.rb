class SprocketDataPush
  require 'csv'
  require 'enumerator' # (for Enumerable#each_slice)
  require 'requires_parameters'
  include RequiresParameters
  
  attr_accessor :options
    
  def initialize(options)
    requires!(options, :customer_id, :start_time, :output_file_directory_path)
    options.reverse_merge! :end_time => Time.now, :show_prices_on_invoice => true, :show_shipping_price_on_invoice => true, :ship_ahead => false, :send_invoice => false
    @options = options
  end
    
  def write_csv!
    orders = SprocketFulfillmentOrder.find(:all, :conditions => ["created_at > ? or created_at < ?", options[:start_time], options[:end_time]])     
    return false if orders.empty?
        
    csv_rows = []

    orders.each do |order|

      products = order.sprocket_fulfillment_order_line_items              
      # Orders with more than 5 products require generating a continuation line, with all the fields blank except the details of
      # the additional products you want to ship in that order. Only the first row should contain the full order details. 
      unassigned_groupings_of_five_or_fewer_products = []
      products.each_slice(5) { |slice| unassigned_groupings_of_five_or_fewer_products << slice }
    
      first_row_in_the_current_order = true                        
      while unassigned_groupings_of_five_or_fewer_products.size > 0
        row_to_add = {}
        
        if first_row_in_the_current_order
          row_to_add = populate_row(row_to_add,order)
          first_row_in_the_current_order = false
        else
          row_to_add["Continued"] = "X"
        end
                        
        grouping_of_five_or_fewer_products = unassigned_groupings_of_five_or_fewer_products.slice!(0)
                
        grouping_of_five_or_fewer_products.each_with_index do |product,index|
          product_number = (index + 1).to_s
          row_to_add["Product0#{product_number}"]  = options[:customer_id] + product.sku
          row_to_add["Quantity0#{product_number}"] = product.quantity
          row_to_add["Price0#{product_number}"]    = product.price if options[:show_prices_on_invoice]
          row_to_add["Discount0#{product_number}"] = product.discount if options[:show_prices_on_invoice]
        end
        
        csv_rows << row_to_add
      end
       
    end
        
    # enter prepared rows in CSV
    filename = File.join(options[:output_file_directory_path], "Sprocket_Data_Push_#{options[:start_time].strftime('%d-%m-%Y')}_#{options[:end_time].strftime('%d-%m-%Y')}.csv")
    titles = SprocketExpress::Data::csv_column_names
    puts filename
        
    CSV.open(filename, 'w') do |writer|
      #first row as titles of fields
      writer << titles
      # now add orders rows from hash based on titles as keys.  
      csv_rows.each do |row|
        row_to_create = titles.inject([]) { |row_to_create,title| row_to_create << (row[title].to_s || '') }
        writer << row_to_create
      end
    end
    
    return filename
  end
  
  def push_to_ftp!
    # @TODO implement push_to_ftp (get ftp server details from Sprocket)
  end
  
  def write_and_push_to_ftp!
    write_csv!
    # @TODO implement write_and_push_to_ftp
  end
  
  private #######################################################
  
  def populate_row(row,order)
    row.merge!(assign_order_attributes_to_corresponding_csv_columns(order))
    row['Foreign'] = order.foreign? ? 'Y' : 'N'
    row['Source_Key'] = options[:customer_id].upcase
    row['Sales_ID'] = options[:customer_id].upcase
    row['UsePrices'] = options[:show_prices_on_invoice] ? 'X' : ''
    row['UseShipAmt'] = options[:show_shipping_price_on_invoice] ? 'X' : ''
    row['ShipAhead'] = options[:ship_ahead] ? 'T' : 'F'
    row['PayMethod'] = options[:send_invoice] ? 'IN' : 'ck'
    { 'Cust_Num' => '0', 'OrderType' => 'IMPORT' }.each_pair { |key,value| row[key] = value }
    ['Internet','NoMail','NoRent','NoEmail','BestOrderPromo'].each { |key| row[key] = 'F' }
    row
  end
  
  def assign_order_attributes_to_corresponding_csv_columns(order)
    csv_columns_to_order_values = {}
    SprocketExpress::Data::order_attributes_to_csv_column_names.each_pair do |order_attribute,csv_column_name|
      csv_columns_to_order_values[csv_column_name] = order.send(order_attribute) if order.respond_to? order_attribute
      if order_attribute == :hold_date || order_attribute == :date_of_original_purchase_transaction
        csv_columns_to_order_values[csv_column_name] = csv_columns_to_order_values[csv_column_name].strftime("%m/%d/%y") unless csv_columns_to_order_values[csv_column_name].blank?
      end
    end
    csv_columns_to_order_values
  end
  
end