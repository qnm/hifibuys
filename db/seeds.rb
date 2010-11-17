require 'lib/openuri.rb'

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

# remote feeds
feeds = { Tivoli => "http://tivolihifi.com/store/second-hand-equipment",
          AudioConnection => "http://audioconnection.com.au/trade-ins-clearance-audio-equipment.asp",
          Carlton => "http://www.carltonaudiovisual.com.au/?q=node/view/7",
          Pymble => "http://www.pymblehifi.com.au/Specials.htm",
          AudioSolutions => "http://audiosolutions.net.au/sydney-audio-solutions/specials.html",
          SimplyHifi => "http://www.simplyhifi.com.au/Trade_ins.htm" }

feeds.each do |ingestor, feed|
  logger.info "Ingesting #{ingestor.to_s}"

  items = ingestor.parse(open(feed)).items
  Item.synchronise(items, {:key => :url} ).each do |item|
    if item.save
      logger.info("Saved #{item.name} with id #{item.id}")
    else
      logger.info("#{item.name} hasnt changed") unless item.id.nil?
    end
  end
end

# and remove any that haven't been updated
Item.find(:all, :conditions => {:delta => false}).each do |item|
  item.delete
end

logger.info "DB Synchronised"
