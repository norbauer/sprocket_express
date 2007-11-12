# To run the plugin specs, you must have: rspec, active_record (>= r6667), and a test database with the name "sprocket_express_test"

# Rails will normally add the files in lib to the load path automatically,
# but we need to manually require them for independent rspec tests (so we don't have to require Rails)
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib/activerecord/lib"))

begin
  require 'active_record'
  require 'rubygems' # @ TODO switch with active_record sequence before release
  require 'spec'
rescue LoadError
  puts "Please install rspec and active_record to run the tests."
  exit 1
end

# Load up the models/modules in our plugin
require 'sprocket_fullfillment_data_map'
require 'sprocket_fulfillment_order'
require 'sprocket_fulfillment_order_line_item'

plugin_spec_dir = File.dirname(__FILE__) 

databases = YAML::load(IO.read(plugin_spec_dir + '/config/database.yml')) 
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + '/db/debug.log')
ActiveRecord::Base.establish_connection(databases['mysql'])
load(File.join(plugin_spec_dir, 'db/schema.rb')) 