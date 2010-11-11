require 'nibbler'
require 'uri'
require 'html/sanitizer'

class SimplyHifiItem < Nibbler
    sanitizer = HTML::FullSanitizer.new
    SITE = "http://www.simplyhifi.com.au/"

    element ".//td[1]/p/font" => :description, :with => lambda { |node| 
      sanitizer.sanitize(node.inner_html.strip.gsub(/[\n]/,"").gsub("  ",'')) }
    element ".//td[1]/p/font/b" => :name, :with => lambda { |node|
      sanitizer.sanitize(node.inner_html.strip.gsub(/[\n]/,"").gsub("  ",'')) }
    element ".//td[1]" => :url, :with => lambda { |node| SITE }
    #element ".//td[1]/p/font" => :original_price, :with => lambda { |node| "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }
    element ".//td[2]/b/font" => :price

    # in this case there's no description in the datasource, so we return an empty string instead
    def to_hash
      { :shop_name    => "Simply Hifi",
        :shop_address => "",
        :shop_suburb  => "",
        :shop_city    => "",
        :shop_state   => "NSW",
        :shop_country => "Australia" }.merge(super)
    end
end

class SimplyHifi < Nibbler
  elements '//div[6]/center/table/tr' => :items, :with => SimplyHifiItem
end
