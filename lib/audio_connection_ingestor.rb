class AudioConnectionIngestor

  require 'hpricot'
  require 'open-uri'
  require 'digest/md5'

  attr_accessor :data
  attr_accessor :current_item
  attr_accessor :container
  attr_accessor :container_defaults

  def initialize(params)
    @data = open(params['url']) { |f| Hpricot(f) }
    @container = eval params['container']['object']

    @container_defaults = params['container']['defaults'].merge(
      :shop_hash => hash)
  end

  def hash
    Digest::MD5.hexdigest("#{self.class} #{@url}").hex
  end

  def wipe
    @container.find_all_by_shop_hash(hash).each { |item|
      item.delete
      puts "Deleted!"
    }
  end

  def ingest
    @data.search("tr/td/div/table/tr/td/table/tr").collect {|@current_item| 
      itemise
    }.reject { |item| item.nil? }
  end

  def itemise
    @container.new(
      { :name         => (@current_item/"/td[2]/a[1]").first.inner_html.strip.gsub(/[",]/,""),
        :description  => '',
        :url          => "http://www.audioconnection.com.au" + (@current_item/"/td[2]/a[1]").first.attributes['href'].strip,
        :price        => (@current_item/"/td[5]").first.inner_html.strip
      }.merge(@container_defaults)
    ) unless (@current_item/"/td[2]/a[1]").first.nil?
  end

end
