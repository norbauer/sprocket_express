# To run the plugin specs, you must have: rspec, mocha, active_record (>= r6667), and a test database with the name "sprocket_express_test"

# Rails will normally add the files in lib to the load path automatically,
# but we need to manually require them for independent rspec tests (so we don't have to require Rails)
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib/activerecord/lib"))

begin
  require 'active_record'
  require 'rubygems' # @ TODO switch with active_record sequence before release
  require 'spec'
  gem 'mocha'
rescue LoadError
  puts "Please install rspec, mocha, and active_record to run the tests."
  exit 1
end

# Load up the models/modules in our plugin
require 'sprocket_fullfillment_data'
require 'sprocket_fulfillment_order'
require 'sprocket_fulfillment_order_line_item'

plugin_spec_dir = File.dirname(__FILE__) 

databases = YAML::load(IO.read(plugin_spec_dir + '/config/database.yml')) 
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + '/db/debug.log')
ActiveRecord::Base.establish_connection(databases['mysql'])
load(File.join(plugin_spec_dir, 'db/schema.rb')) 

Spec::Runner.configure do |config|
  config.mock_with :mocha
end


# @TODO remove following line
require 'ruby-debug'



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
  { :ship_via => SprocketExpress::Data.carrier_names_to_carrier_codes['USPS Priority Mail'],
    :billing_last_name => 'Richard',
    :billing_first_name => 'Dawkins',
    :billing_company => 'Oxford University',
    :billing_address_1 => 'Bodleian Library',
    :billing_address_2 => 'Floor 1',
    :billing_city  => 'Oxford',
    :billing_state => 'Oxford',
    :billing_zipcode => 'OX1 3BG',
    :billing_phone => '12345678910',
    :billing_email => 'e@e.com',
    :billing_country => SprocketExpress::Data.country_names_to_country_codes['United kingdom'],
    :date_of_original_purchase_transaction => Time.now,
    :id_from_original_purchase_transaction => Time.now  }
end
