require 'yaml'
logger = Logger.new(STDOUT)

category = "electronics/hifi"

base = "config/harvester/#{category}"

logger.info "Deleting existing data"

[Item, SyncItem, Shop, Entity].each do |model|
  model.delete_all
end

["manufacturers", "types"].each do |entity|
  entity_data = File.open("#{base}/entities/#{entity}.yml", "r") { |f| YAML::load (f) }
  Entity.create(entity_data.inject([]) { |v,e| v << {:category => entity.singularize, :name => e} })
end

shop_data = File.open("#{base}/entities/shops.yml", 'r') { |shops| YAML::load (shops) }
shops = Shop.create(shop_data)

shops.each do |shop|
  synchroniser = Synchroniser::Config::Params.new("/#{base}/#{shop.filename}.yml", shop.filename, shop.defaults).get_sync
  synchroniser.sync
end

logger.info "DB Synchronised"

