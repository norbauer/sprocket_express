# To run the plugin specs, you must have: rspec, mocha, active_record (>= r6667), and a test database with the name "sprocket_express_test"

# Rails will normally add the files in lib to the load path automatically,
# but we need to manually require them for independent rspec tests (so we don't have to require Rails)
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib/activerecord/lib"))

begin
  require 'rubygems'
  require 'active_record'
  require 'spec'
  gem 'mocha'
rescue LoadError
  puts "Please install rspec, mocha, and active_record to run the tests."
  exit 1
end

# Load up the models/modules in our plugin
require 'data'
require 'sprocket_express_order'
require 'sprocket_express_order_line_item'

plugin_spec_dir = File.dirname(__FILE__) 

databases = YAML::load(IO.read(plugin_spec_dir + '/config/database.yml')) 
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + '/db/debug.log')
ActiveRecord::Base.establish_connection(databases['mysql'])
load(File.join(plugin_spec_dir, 'db/schema.rb')) 

Spec::Runner.configure do |config|
  config.mock_with :mocha
end


require 'yaml'

class Hash
  # From http://wincent.com/knowledge-base/Fixtures_considered_harmful%3F

  def except(*keys)
    self.reject { |k,v| keys.include?(k || k.to_sym) }
  end
  
  def with(overrides = {})
    self.merge overrides
  end
  
  def only(*keys)
    self.reject { |k,v| !keys.include?(k || k.to_sym) }
  end

end

# Valid attributes

def valid_order_attributes
  { :ship_via => SprocketExpress::carriers('USPS Priority Mail'),
    :billing_last_name => 'Richard',
    :billing_first_name => 'Dawkins',
    :billing_company => 'Oxford University',
    :billing_address_1 => 'Bodleian Library',
    :billing_address_2 => 'Malmöñ étage',
    :billing_city  => 'Oxford',
    :billing_state => 'Oxford',
    :billing_zipcode => 'OX1 3BG',
    :billing_phone => '12345678910',
    :billing_email => 'e@e.com',
    :billing_country => SprocketExpress::countries('United kingdom'),
    :date_of_original_purchase_transaction => Date.new(2007,04,28),
    :id_from_original_purchase_transaction => '4337',
    :shipping_same_as_billing => true }
end

def valid_line_item_attributes
  { :sku => '3743',
    :quantity => 37,
    :price => 99.99,
    :discount_percent => 43 }
end