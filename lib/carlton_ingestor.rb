class CarltonIngestor
  include Synchroniser::Ingestor::Uri

  require 'hpricot'

  def ingest(container)
    Hpricot(@data).search("/html/body/table/tr[2]/td[2]/table/tr[2]/td/table").collect {|item|
      itemise(item, container.clone) 
    }.reject { |item| 
      item.nil? 
    }
  end

  def itemise(item, container)
    if (item/"tr/td/div/a").inner_html.scan(/\$([0-9\.,.]{1,})/).nil? == false
      container.instance_eval{
        self.name         = (item/"tr/td/div/a")[0].inner_html.split("-").first.split(",").first.split("WAS").first
        self.description  = (item/"tr/td/p").map {|element| element.inner_html}.join(" ").gsub("\n"," ").gsub("\""," ")
        self.url          = "http://www.carltonaudiovisual.com.au/" + (item/"tr/td/div/a").first.attributes['href']
        # we gotta grab out the minimum price from the array
        self.price        = CarltonIngestor.monetize(item)
        self
      }
    end
  end

  def self.monetize(item)
      price = (item/"tr/td/div").to_s.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s
      if (price.empty?) 
        "$Call"
      else
        "$#{price}"
      end
  end
end
