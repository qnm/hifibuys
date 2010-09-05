logger = Logger.new(STDOUT)

logger.info "Deleting existing data"
Harvester::Base.wipe
Harvester::Base.category = "electronics/hifi"

{"manufacturers" => Entity, "types" => Entity, "shops" => Shop}. each do |name, entity|
  Harvester::Base.populate(name, entity)
end

Shop.find(:all).each do |shop|
  Harvester::Base.synchroniser(shop).sync
end

logger.info "DB Synchronised"
