require 'nibbler'
require 'uri'
require 'nokogiri'

class CarltonItem < Nibbler
    SITE = URI("http://www.carltonaudiovisual.com.au/")
    element ".//tr/td/div/a" => :name, :with => lambda { |node| node.text.split("-").first.split(",").first.split("WAS").first.strip }
    element ".//tr/td/p" => :description
    element ".//tr/td/div/a/@href" => :url, :with => lambda { |node| SITE + node.text }
    element ".//tr/td/div" => :price, :with => lambda { |node| node.text.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_f }

=begin
    element ".//td[2]/a[1]/@href" => :url, :with => lambda { |node| SITE + node.text }
    element ".//td[5]" => :price, :with => lambda { |node| '$' + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s + ".00" }

    element ".//td[2]/h3/a[position() = 1]" => :name, :with => lambda { |node| node.text.gsub(/- Second [hH]and/,"").strip }
    element ".//td[2]/div" => :description, :with => lambda { |node| node.text.gsub(/Second [Hh]and/,"").strip }
    element ".//td[2]/h3/a/@href" => :url
    element ".//td[3]" => :price, :with => lambda { |node| node.text.scan(/\$([0-9\.,.]{1,})/).first.first.to_f }
=end

=begin
        self.name         = (item/"tr/td/div/a")[0].inner_html.split("-").first.split(",").first.split("WAS").first
        self.description  = (item/"tr/td/p").map {|element| element.inner_html}.join(" ").gsub("\n"," ").gsub("\""," ")
        self.url          = "http://www.carltonaudiovisual.com.au/" + (item/"tr/td/div/a").first.attributes['href']
        # we gotta grab out the minimum price from the array
        self.price        = CarltonIngestor.monetize(item)
        self
=end
end

class Carlton < Nibbler
  elements "//html/body/table/tr[2]/td[2]/table/tr[2]/td/table" => :items, :with => CarltonItem

  def ingest(container)
    self.items.map { |item| Item.new(item.to_hash) }
  end
end
