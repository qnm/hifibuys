require 'nibbler'
require 'uri'
include Feed

class TivoliItem < Nibbler
    element ".//td[1]/a/img/@src" => :image_url, :with => lambda { |node| node.text.strip }
    element ".//td[2]/a/@href" => :url, :with => lambda { |node| "http://tivolihifi.com#{node.text}" }

    element ".//td[2]/a" => :name, :with => lambda { |node| node.text.strip }
    element ".//td[3]" => :description, :with => lambda { |node| node.text.strip }
    element ".//td[4]" => :original_price, :with => lambda { |node| '$' + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s + ".00" }
    element ".//td[5]" => :price, :with => lambda { |node| '$' + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s + ".00" }

    def to_hash
      { 
        :seller_id    => 11,
        :submitter_id => 11,
      }.merge(super)
    end
end

class Tivoli < Scraper
  consumes APP_CONFIG['pipes']['tivoli'][0]['sources'][0]
  synchronises Item, :unique => :url

  elements '//div[@id="content-content"]/table/tbody/tr' => :items, :with => TivoliItem
  element '//li[@class="pager-next"]/a/@href' => :next_page_url

  # augment to recursively parse other pages
  def parse
    super
    if next_page_url
      @doc = get_document(URI("http://tivolihifi.com" + next_page_url))
      self.parse
    end
    self
  end
end
