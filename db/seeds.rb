logger = Logger.new(STDOUT)

logger.info "Deleting existing data"

Item.update_all(:delta => false)
Entity.delete_all

@base = 'config/harvester'
@category = 'electronics/hifi'

entity_types = [  "manufacturers",
                  "types" ]

entity_types.each do |entity_type|
  logger.info("Populating #{entity_type.pluralize}")
  data = File.open("#{@base}/#{@category}/#{entity_type}.yml", "r") { |f| YAML::load(f) }
  Entity.create(data.values)
end

feeds = { Tivoli => "spec/integration/siteref/tivoli.html",
          AudioConnection => "spec/integration/siteref/audioconnection.html",
          Carlton => "spec/integration/siteref/carlton.html" }

feeds.each do |ingestor, feed|
  logger.info "Ingesting #{ingestor.to_s}"
  Harvester.synchronise(ingestor, feed)
end

# and remove any that haven't been updated
Item.find(:all, :conditions => {:delta => false}).each do |item|
  item.delete
end

logger.info "DB Synchronised"
