class AudioConnectionIngestor

  require 'hpricot'

  attr_accessor :data
  attr_accessor :current_item
  attr_accessor :container

  def initialize(params)
    @data = open(params['url']) { |f| Hpricot(f) }
    @container = eval params['container']
  end

  def url
  end

  def ingest
    @data.search("tr/td/div/table/tr/td/table/tr").collect {|@current_item| 
      itemise
    }.reject { |item| item.nil? }
  end

  def itemise
    @container.new(
      :name         => (@current_item/"/td[2]/a[1]").first.inner_html.strip.gsub(/[",]/,""),
      :description  => '',
      :url          => "http://www.audioconnection.com.au" + (@current_item/"/td[2]/a[1]").first.attributes['href'].strip,
      :price        => (@current_item/"/td[5]").first.inner_html.strip
    ) unless (@current_item/"/td[2]/a[1]").first.nil?
  end

end
