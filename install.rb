# create directory to store csv files...
require 'fileutils'
@storage_directory = File.dirname(__FILE__) +'/../../../public/sprocket_fulfillment_csv_files'
p @storage_directory

FileUtils.mkdir_p @storage_directory

# Output the README file to the console
puts IO.read(File.join(File.dirname(__FILE__), 'README'))