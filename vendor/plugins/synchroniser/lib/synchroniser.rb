class Synchroniser

  attr_accessor :container
  attr_accessor :ingestors

  def initialize(container, ingestors)
    @container = container
    @ingestors = ingestors
  end

  def ingest
    @ingestors.map {|ingestor|
      ingestor.ingest(@container)
    }.flatten
  end

  def sync
    if @container.group.nil?
      raise ArgumentError, "Group not set on container '#{@container.class}'"
    end

    @container.find_all_flags.each {|flag|
      flag.status = 0
      flag.save
    }

    SyncItem.logger.info("Reset status for the set '#{@container.group}'")

    ingest.each {|item|
      if item.item.nil?
        raise NotImplementedError, "Method call '#{@container.class}.item' is returning null. Please ensure it returns a unique value per instance."
      end
      item.save
    }

    @container.delete_expired_items
  end
end

require File.join(File.dirname(__FILE__), 'synchroniser', 'config.rb')
require File.join(File.dirname(__FILE__), 'synchroniser', 'model.rb')
require File.join(File.dirname(__FILE__), 'synchroniser', 'ingestor.rb')
require File.join(File.dirname(__FILE__), 'synchroniser', 'ingestor', 'uri.rb')
