require 'yaml'

puts "Deleting existing data"

[Item, SyncItem, Shop, Entity].each do |model|
  model.delete_all
end

["manufacturers", "types"].each do |entity|
  entities = File.open("config/#{entity}.yml", "r") { |f| YAML::load (f) }
  Entity.create(entities.inject([]) { |v,e| v << {:category => entity.singularize, :name => e} })
end

shops_data = File.open('config/shops.yml', 'r') { |shops| YAML::load (shops) }
shops = Shop.create(shops_data)

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

