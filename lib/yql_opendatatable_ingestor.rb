class YqlOpendatatableIngestor

  require 'uri'
  require 'yajl/http_stream'
  require 'yajl/json_gem'
  require 'digest/md5'

  attr_accessor :yql
  attr_accessor :data
  attr_accessor :hash
  attr_accessor :current_item
  attr_accessor :container
  attr_accessor :container_defaults


  def initialize(params, url)
    resource = Yajl::HttpStream.get(build_url(url))
    @data = resource['query']['results']['products']['product']
    @hash = Digest::MD5.hexdigest("#{self.class} #{url}").hex
    @container = eval params['container']['object']
    @container_defaults = params['container']['defaults'].merge(
      :shop_hash => hash)
  end

  def wipe
    @container.find_all_by_shop_hash(@hash).each { |item|
      item.delete
      puts "Deleted!"
    }
  end

  def ingest
    @data.collect {|@current_item| 
      itemise
    }
  end

  def itemise
    @container.new(
      { :name         => @current_item['name'],
        :description  => @current_item['description'],
        :url          => @current_item['url'],
        :price        => @current_item['price']
      }.merge(@container_defaults)
    )
  end

  private

  def build_url(url)
    yql = "use \"#{url}\"  as shop; select * from shop;"

    base = "http://query.yahooapis.com/v1/public/yql?format=json&q="
    URI.parse(base + URI.escape(yql))
  end

end
