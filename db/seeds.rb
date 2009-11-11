# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# wipe the existing data

puts "Deleting existing data"

Item.delete_all
SyncItem.delete_all

feeds = ["audio_connection", "tivoli", "carlton"]

feeds.each do |name|
  synchroniser = Synchroniser::Config::Params.new("/config/ingestors.yml", name).get_sync
  synchroniser.sync
end
