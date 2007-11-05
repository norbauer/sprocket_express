# Install hook code here

# create directory to store csv files...
require 'fileutils'
@storage_directory = File.dirname(__FILE__) +'/../../../public/sprocket_csv_files'
p @storage_directory

FileUtils.mkdir_p @storage_directory