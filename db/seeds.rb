logger = Logger.new(STDOUT)

logger.info "Deleting existing data"
harvester = Harvester::Base.new("electronics/hifi")
harvester.wipe

{"manufacturers" => Entity, "types" => Entity, "shops" => Shop}. each do |name, entity|
  logger.info("Populating #{name.pluralize}")
  creations = harvester.populate(name, entity)
  logger.info("Created #{creations.count} #{name.pluralize}")
end

Shop.find(:all).each do |shop|
  logger.info "Ingesting #{shop.name}"
  synchroniser = harvester.synchroniser(shop)
  synchroniser.sync
  synchroniser.display_stats
end

logger.info "DB Synchronised"
