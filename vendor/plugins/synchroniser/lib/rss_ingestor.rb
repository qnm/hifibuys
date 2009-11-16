class RssIngestor
  include Synchroniser::Ingestor::Uri

  require 'hpricot'

  def ingest(container)
    Hpricot(@data).search("rss/channel/item").collect {|item|
      itemise(item, container.clone) 
    }.reject { |item| 
      item.nil? 
    }
  end

  def itemise(item, container)
    container.instance_eval{
      self.url = ((item/"guid").inner_html)
      self.title =  ((item/"title").inner_html)
      self
    }
  end

end
