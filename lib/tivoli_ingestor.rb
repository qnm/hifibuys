class TivoliIngestor

  require 'hpricot'
  require 'open-uri'
  require 'digest/md5'

  attr_accessor :data
  attr_accessor :hash
  attr_accessor :current_item
  attr_accessor :container
  attr_accessor :container_defaults

  def initialize(params, url)
    @data = open(url) { |f| Hpricot(f) }
    @hash = Digest::MD5.hexdigest("#{self.class} #{url}").hex
    @container = eval params['container']['object']
    @container_defaults = params['container']['defaults'].merge(
      :shop_hash => @hash)
  end

  def wipe
    @container.find_all_by_shop_hash(@hash).each { |item|
      item.delete
      puts "Deleted!"
    }
  end

  def ingest
    @data.search("div[2]/div[2]/table/tr").collect {|@current_item| 
      itemise
    }.reject { |item| item.nil? }
  end

  def itemise
    @container.new(
      { :name         => (@current_item/"/td[2]/h3/a").first.inner_html.gsub(/- Second hand/,""),
        # :manufacturer => (@current_item/"/td[1]").first.inner_html.strip.gsub(/[",]/,""),
        :description  => (@current_item/"/td[2]/div").first.inner_html,
        :url          => (@current_item/"/td[2]/h3/a").first.attributes['href'],
        :price        => "$" + (@current_item/"/td[3]").inner_html.scan(/\$([0-9\.,.]{1,})/).first.first
      }.merge(@container_defaults)
    ) unless (@current_item/"/td[2]").first.nil?
  end

end
