require 'yaml'

module Harvester

  class Base

    def self.category=(category)
      @@category = category
    end

    def self.category
      @@category
    end

    def self.base
      "config/harvester/#{self.category}" 
    end

    def self.wipe
      [Item, SyncItem, Shop, Entity].each do |model|
        model.delete_all
      end
    end

    def self.populate(name, entity)
      data = File.open("#{self.base}/entities/#{name}.yml", "r") { |f| YAML::load (f) }
      entity.create(entity.normalise(data, name))
    end

    def self.synchroniser(shop)
      Synchroniser::Config::Params.new("/#{base}/#{shop.filename}.yml", shop.filename, shop.defaults).get_sync
    end

  end

end
