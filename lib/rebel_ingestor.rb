class RebelIngestor
  include Synchroniser::Ingestor::Uri

  require 'nokogiri'
  require 'cgi'

  def pagination()
		Nokogiri::HTML(@data).css("#topStatusNav").css("a").inject([]) do |store, node|
			store << "http://www.rebelsport.com.au" + node['href']
		end	
	end

  def ingest(container)
    # load the google category in a rather inefficient way
    breadcrumb = Nokogiri::HTML(@data).css('#breadCrumbs').css("a")
    breadcrumb.shift
    container.item_type = CGI.escapeHTML(breadcrumb.inject([]) { |var, element| var << element.text }.join(" > "))

    doc = Nokogiri::HTML(@data).css("#browseCell").collect {|item|
      itemise(item, container.clone) 
    }.reject { |item| 
      item.nil? 
    }
  end

  def itemise(item, container)
    container.instance_eval{
      self.name = name = item.css('.innerBrowseCell').css('div')[2].content.gsub(/\r\n/,"").split("-")[0].strip
      self.description = name = item.css('.innerBrowseCell').css('div')[2].content.gsub(/\r\n/,"").split("-")[0].strip
      colour = item.css('.innerBrowseCell').css('div')[2].content.gsub(/\r\n/,"").split("-")[1].to_s.strip
      self.colour = colour unless colour == name
      self.url = "http://www.rebelsport.com.au/ecom/rebel/" + item.css("div a")[1]['href']
      self.price = "$" + item.css('.innerBrowseCell').children[6].content.scan(/\$([0-9\.,.]{1,})/).first.first unless item.css('.innerBrowseCell').children[6].content.scan(/\$([0-9\.,.]{1,})/).first.instance_of?(Array) == false
      self.image = "http://www.rebelsport.com.au" + item.css("img")[0]['src']
      self
    }
  end

end
