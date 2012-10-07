require 'nibbler'
require 'uri'
include Feed

class SimplyHifiItem < Nibbler
  SITE = "http://www.simplyhifi.com.au/"

  element "//div[1]/div/h2/a" => :name, :with => lambda { |node| tidy(node.inner_html) }
  element "//div[1]/div/h2/a/@href" => :url, :with => lambda { |node| tidy(node.inner_html) }
  element "//div[1]/div/h2/a" => :price, :with => lambda { |node|  node.text.scan(/(\$[0-9,]{1,})/).flatten.first.to_s.gsub(',','') }
  element "//div[0]/div/a/img/@src" => :image_url

  def to_hash
    { 
      :seller_id    => 10,
      :submitter_id => 10,
    }.merge(super)
  end
end

class SimplyHifi < Scraper
  consumes APP_CONFIG['pipes']['simply_hifi'][0]['sources'][0]
  synchronises Item, :unique => :url

  elements '//div[@class="product_grid_display group"]/div' => :items, :with => SimplyHifiItem
  element '//a[@title="Next Page"]/@href' => :next_page_url
  # augment to recursively parse other pages
  def parse
    super
    if next_page_url
      @doc = get_document(URI(next_page_url))
      self.parse
    end
    self
  end

end
