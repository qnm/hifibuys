class PymbleIngestor
  include Synchroniser::Ingestor::Uri

  require 'hpricot'

  def ingest(container)
    Hpricot(@data).search("table/tr/td/div/table/tr/td/div").collect {|item|
      itemise(item, container.clone) 
    }.reject { |item| 
      item.nil? 
    }
  end

  def itemise(item, container)
    if (item/"/td[2]").first.nil? == false
      container.instance_eval{
        self.name         = (item/"/td[2]/h3/a").first.inner_html.gsub(/- Second hand/,"")
        self.description  = (item/"/td[2]/div").first.inner_html
        self.url          = (item/"/td[2]/h3/a").first.attributes['href']
        self.price        = "$" + (item/"/td[3]").inner_html.scan(/\$([0-9\.,.]{1,})/).first.first
        self
      }
    end
  end

end
