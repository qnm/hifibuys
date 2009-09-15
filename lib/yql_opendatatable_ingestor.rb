class YqlOpendatatableIngestor
  attr_accessor :yql

  def initialize(data_table_url)
    @yql = "use \"#{data_table_url}\"  as shop; select * from shop;"
  end

  def ingest
    require 'uri'
    require 'yajl/http_stream'
    require 'yajl/json_gem'

    data.each do |element|
      puts element.inspect
    end
  end

  def build_url
    base = "http://query.yahooapis.com/v1/public/yql?format=json&q="
    URI.parse(base + URI.escape(@yql))
  end

  def data
    resource = Yajl::HttpStream.get(build_url)
    resource['query']['results']['products']
  end
end
