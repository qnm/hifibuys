require 'yaml'

module Harvester

  class Base

    def initialize(category)
      @base = "config/harvester"
      @@category = category
    end

    def wipe
      [Item, SyncItem, Shop, Entity].each do |model|
        model.delete_all
      end
    end

    def populate(name, entity)
      data = File.open("#{@base}/#{@@category}/#{name}.yml", "r") { |f| YAML::load(f) }
      entity.create(data.values)
    end

    def synchroniser(shop)
      Synchroniser.new(Item.new(shop.defaults), shop.ingestors)
    end

  end

end
