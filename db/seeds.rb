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
Shop.delete_all
Entity.delete_all

# Add in our default shops
shops = [{  :name     => "Audio Connection",
            :address  => "",
            :suburb   => "Leichhardt",
            :city     => "Sydney",
            :state    => "NSW",
            :country  => "Australia",
            :feed     => 'audio_connection' },

        {   :name     => "Tivoli",
            :address  => "155-157 Camberwell Road",
            :suburb   => "Hawthorn East",
            :city     => "Melbourne",
            :state    => "VIC",
            :country  => "Australia",
            :feed     => 'tivoli' },

        {   :name     => "Carlton Audio Visual",
            :address  => "164-172 Lygon Street",
            :suburb   => "Carlton",
            :city     => "Melbourne",
            :state    => "Victoria",
            :country  => "Australia",
            :feed     => 'carlton' }]

shops = Shop.create(shops)

entities =      [{  :name => "Arcam" },
                {   :name => "Denon" },
                {   :name => "Micromega" },
                {   :name => "Myryad" },
                {   :name => "Omega" },
                {   :name => "Krell" },
                {   :name => "MBL" },
                {   :name => "Musical Fidelity" },
                {   :name => "Threshold" },
                {   :name => "Pathos" },
                {   :name => "Yamaha" },
                {   :name => "Schroers & Schroers" },
                {   :name => "Classe Audio" },
                {   :name => "Theta" },
                {   :name => "Cyrus" },
                {   :name => "Audio Research" },
                {   :name => "CEC" },
                {   :name => "Audio Note" },
                {   :name => "Meridian" },
                {   :name => "Definitive Technology" },
                {   :name => "AE" },
                {   :name => "ATC" },
                {   :name => "Dali" },
                {   :name => "Eventus" },
                {   :name => "MBL" },
                {   :name => "Aelite" },
                {   :name => "Aerial Acoustics" },
                {   :name => "Triangle" },
                {   :name => "Revel" },
                {   :name => "Aegis" },
                {   :name => "Klipsch" },
                {   :name => "Anthem" },
                {   :name => "Hovland" },
                {   :name => "Mark Levinson" },
                {   :name => "Jadis" },
                {   :name => "Graham Robin" },
                {   :name => "Clearaudio" },
                {   :name => "Oracle" },
                {   :name => "Sony" },
                {   :name => "Audiolab" },
                {   :name => "Vincent" },
                {   :name => "Coincident" },
                {   :name => "Avalon" },
                {   :name => "Focus Audio" },
                {   :name => "Genesis" },
                {   :name => "Martin Logan" },
                {   :name => "Rega" },
                {   :name => "Wilson" },
                {   :name => "Magnum" },
                {   :name => "Gryphon" },
                {   :name => "Thiel" },
                {   :name => "REL" },
                {   :name => "Linn" }]

entities = Entity.create(entities.map { |e| e.merge(:category => "manufacturer") })

shops.each do |shop|
  configuration = Synchroniser::Config::Params.new("/config/ingestors.yml", shop.feed)
  configuration.config["params"]["container"]["defaults"].merge!({:shop_id      => shop.id})
  configuration.config["params"]["container"]["defaults"].merge!({:shop_name    => shop.name})
  configuration.config["params"]["container"]["defaults"].merge!({:shop_address => shop.address})
  configuration.config["params"]["container"]["defaults"].merge!({:shop_suburb  => shop.suburb})
  configuration.config["params"]["container"]["defaults"].merge!({:shop_city    => shop.city})
  configuration.config["params"]["container"]["defaults"].merge!({:shop_state   => shop.state})
  configuration.config["params"]["container"]["defaults"].merge!({:shop_country => shop.country})
  synchroniser = configuration.get_sync
  synchroniser.sync
end

puts "DB Synchronised"

