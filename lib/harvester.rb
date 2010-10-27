require 'yaml'

module Harvester

  class Base

    def initialize(category)
      @base = "config/harvester"
      @@category = category
    end

    def wipe
      [Shop, Entity].each do |model|
        model.delete_all
      end
    end

    def scrub
      [Item, SyncItem, Shop, Entity].each do |model|
        model.delete_all
      end
    end

    def populate(name, entity)
      data = File.open("#{@base}/#{@@category}/#{name}.yml", "r") { |f| YAML::load(f) }
      entity.create(data.values)
    end

    def synchronise(shop)
      shop.ingest.map do |ingestee| 
        item = Item.find_or_create_by_url(ingestee.url)
        item.attributes = shop.defaults
        item.attributes = ingestee.to_hash 

        if item.save
          puts "Saved #{item.name} with id #{item.id}"
        else
          puts "#{item.name} hasnt changed" unless item.id.nil?
        end
      end
    end
  end

end
