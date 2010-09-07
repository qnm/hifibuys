logger = Logger.new(STDOUT)

logger.info "Deleting existing data"
Harvester::Base.wipe
Harvester::Base.category = "electronics/hifi"

{"manufacturers" => Entity, "types" => Entity, "shops" => Shop}. each do |name, entity|
  Harvester::Base.populate(name, entity)
end

Shop.find(:all).each do |shop|
  logger.info "Ingesting #{shop.name}"
  synchroniser = Harvester::Base.synchroniser(shop)
  synchroniser.sync
  synchroniser.display_stats
end

logger.info "DB Synchronised"
