module Synchroniser::Ingestor::Yql
  include Synchroniser::Ingestor

  require 'uri'
  require 'open-uri'
  require 'yajl/http_stream'
  require 'yajl/json_gem'
  require 'digest/md5'

  def load(uri)
    resource = Yajl::HttpStream.get(build_url(url))
    @data = resource['query']['results']['products']['product']
  end

  private

  def build_url(url)
    yql = "use \"#{url}\"  as shop; select * from shop;"

    base = "http://query.yahooapis.com/v1/public/yql?format=json&q="
    URI.parse(base + URI.escape(yql))
  end

end
