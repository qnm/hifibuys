module Synchroniser::Ingestor

  require 'hpricot'
  require 'open-uri'
  require 'digest/md5'

  attr_accessor :data
  attr_accessor :hash
  attr_accessor :current_item
  attr_accessor :container
  attr_accessor :container_defaults

  def initialize(params, url, name)
    @data = open(url) { |f| Hpricot(f) }
    @container = eval params['container']['object']
    @container.set = name
    @container.defaults = params['container']['defaults'] || {}
  end

  def sync
    @container.find_all_flags.each {|flag|
      flag.status = 0
      flag.save
    }

    puts "Reset status for the set '#{@container.set}'"

    ingest.each {|item|
      item.save
    }

    @container.delete_expired_items
  end


end
