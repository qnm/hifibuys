class CarltonIngestor

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
    #             /html/body/table/tbody/tr[2]/td[2]/table/tbody/tr[2]/td/table[3]/tbody
    @data.search("/html/body/table/tr[2]/td[2]/table/tr[2]/td/table").collect {|@current_item| 
      itemise
    }.reject { |item| item.nil? }
  end

  def itemise
    @container.new(
      { :name         => (@current_item/"tr/td/div/a")[0].inner_html.split("-").first.split(",").first.split("WAS").first,
        :description  => (@current_item/"tr/td/p").map {|element| element.inner_html}.join(" ").gsub("\n"," ").gsub("\""," "),
        :url          => (@current_item/"tr/td/div/a").first.attributes['href'],
        # we gotta grab out the minimum price from the array
        :price        => "$" + (@current_item/"tr/td/div/a")[0].inner_html.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s

      }.merge(@container_defaults)
    ) unless (@current_item/"tr/td/div/a").inner_html.scan(/\$([0-9\.,.]{1,})/).nil?
  end

end
