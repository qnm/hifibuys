class AudioConnectionIngestor
  include Synchroniser::Ingestor::Uri

  require 'hpricot'

  def ingest(container)
    Hpricot(@data).search("tr/td/div/table/tr/td/table/tr").collect {|item|
      itemise(item, container.clone) 
    }.reject { |item| 
      item.nil? 
    }

  end

  def itemise(item, container)
    if (item/"/td[2]/a[1]").first.nil? == false
      container.instance_eval{
        self.name         = (item/"/td[2]/a[1]").first.inner_html.strip.gsub(/[",]/,"")
        self.description  = ''
        self.url          = "http://www.audioconnection.com.au" + (item/"/td[2]/a[1]").first.attributes['href'].strip
        self.price        = (item/"/td[5]").first.inner_html.strip
        self
      }
    end
  end

end
