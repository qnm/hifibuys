class Harvester
  def self.synchronise(ingestor, feed)
    ingestor.parse(open(feed)).items.each do |ingestee| 
      item = Item.find_or_create_by_url(ingestee.url)
      item.attributes = ingestee.to_hash.merge(:delta => true)

      if item.save
        puts "Saved #{item.name} with id #{item.id}"
      else
        puts "#{item.name} hasnt changed" unless item.id.nil?
      end
    end
  end
end
