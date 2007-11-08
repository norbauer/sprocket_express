namespace :db do
  desc "Creates the order csv file for sprocket fulfillment  from DB. They will be Saved inside lib/sprocket_fulfillment/csv_files"
  task :create_sprocket_order_csv => :environment do
    filename = SprocketFulfillmentOrder.create_order_file_for(Time.now.yesterday)
    p "**File created. File file here... #{filename}"
  end
end
