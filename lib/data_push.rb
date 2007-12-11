module SprocketExpress
  
  class DataPush
    
    require 'enumerator' # (for Enumerable#each_slice)
    require 'net/ftp'
    require 'net_ftp_extensions'
    require 'requires_parameters'
    include RequiresParameters
  
    attr_accessor :options
  
    SPROCKET_FTP_DOMAIN = 'ftp.xeran.com'
    
    def initialize(options)
      requires!(options, :customer_id)
      options.reverse_merge! :show_prices_on_invoice => true, :show_shipping_price_on_invoice => true, :ship_ahead => false, :send_invoice => false
      @options = options
    end
    
    def create_csv
      orders = SprocketExpressOrder.find_all_by_sent_for_fulfillment(false)     
      return false if orders.empty?
        
      product_rows = []
    
      orders.each do |order|
    
        products = order.sprocket_express_order_line_items              
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
            # continuation lines (foolishly) require a shipping address to be specified
            ['last_name','first_name','company','address_1','address_2','city','state','zipcode','country','phone','email'].each do |attribute_suffix|
              row_to_add[SprocketExpress::order_attributes_to_csv_column_names["shipping_#{attribute_suffix}".intern]] = order.send("#{(order.shipping_same_as_billing? ? 'billing_' : 'shipping_') + attribute_suffix }".intern)
            end
          end
                        
          grouping_of_five_or_fewer_products = unassigned_groupings_of_five_or_fewer_products.slice!(0)
                
          grouping_of_five_or_fewer_products.each_with_index do |product,index|
            product_number = (index + 1).to_s
            row_to_add["Product0#{product_number}"]  = options[:customer_id] + product.sku
            row_to_add["Quantity0#{product_number}"] = product.quantity
            row_to_add["Price0#{product_number}"]    = product.price if options[:show_prices_on_invoice]
            row_to_add["Discount0#{product_number}"] = product.discount_percent if options[:show_prices_on_invoice]
          end
        
          product_rows << row_to_add 
        end
       
      end
        
      # enter prepared rows in CSV
      titles = SprocketExpress::csv_column_names
       
      csv_rows = []
      #first row as titles of fields
      csv_rows << (titles.join(',') + "\n")
      # now add orders rows from hash based on titles as keys.  
      product_rows.each do |row|
        row_to_create = titles.inject([]) { |row_to_create,title| row_to_create << prepare_value_for_csv(row[title]) }
        csv_rows << (row_to_create.join(',') + "\n")
      end
    
      return csv_rows, orders
    end
  
    def deliver!
      requires!(options,:ftp_username,:ftp_password)
      csv_rows, orders = create_csv
      if csv_rows && orders
        Net::FTP.open(SPROCKET_FTP_DOMAIN) do |ftp|
          ftp.extend(NetFtpExtensions)
          ftp.login(options[:ftp_username],options[:ftp_password])
          remote_filename = "#{options[:customer_id].upcase}_#{Time.now.strftime('%d-%m-%Y')}.csv"
          ftp.send_text_lines(csv_rows, remote_filename)
        end
        orders.each { |o| o.update_attribute(:sent_for_fulfillment, true) }
      end
    end
  
    private #######################################################
  
    def populate_row(row,order)
      row.merge!(assign_order_attributes_to_corresponding_csv_columns(order))
      row['Foreign']    = order.foreign? ? 'Y' : 'N'
      row['Source_Key'] = options[:customer_id].upcase
      row['Sales_ID']   = options[:customer_id].upcase
      row['UsePrices']  = options[:show_prices_on_invoice] ? 'X' : ''
      row['UseShipAmt'] = options[:show_shipping_price_on_invoice] ? 'X' : ''
      row['ShipAhead']  = options[:ship_ahead] ? 'T' : 'F'
      row['PayMethod']  = options[:send_invoice] ? 'IN' : 'ck'
      { 'Cust_Num' => '0', 'OrderType' => 'IMPORT' }.each_pair { |key,value| row[key] = value }
      ['Internet','NoMail','NoRent','NoEmail','BestOrderPromo'].each { |key| row[key] = 'F' }
      row
    end
  
    def assign_order_attributes_to_corresponding_csv_columns(order)
      csv_columns_to_order_values = {}
      SprocketExpress::order_attributes_to_csv_column_names.each_pair do |order_attribute,csv_column_name|
        csv_columns_to_order_values[csv_column_name] = order.send(order_attribute) if order.respond_to? order_attribute
        if order_attribute == :hold_date || order_attribute == :date_of_original_purchase_transaction
          csv_columns_to_order_values[csv_column_name] = csv_columns_to_order_values[csv_column_name].strftime("%m/%d/%y") unless csv_columns_to_order_values[csv_column_name].blank?
        end
      end
      csv_columns_to_order_values
    end
  
    def prepare_value_for_csv(value)
      if value.kind_of? String
        "\"#{value}\""
      elsif value.kind_of? Integer
        value
      elsif value.respond_to?(:to_f) && !value.nil?
        "%.2f" % value.to_f
      else
        ''
      end
    end
  
  end
  
end