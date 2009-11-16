module Synchroniser::Ingestor

  attr_accessor :container

  def sync
    @container.find_all_flags.each {|flag|
      flag.status = 0
      flag.save
    }

    SyncItem.logger.info("Reset status for the set '#{@container.group}'")

    ingest.each {|item|
      item.save
    }

    @container.delete_expired_items
  end
end
