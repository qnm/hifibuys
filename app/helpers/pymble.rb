require 'nibbler'
require 'uri'
require 'html/sanitizer'

class PymbleItem < Nibbler
    @@sanitizer = HTML::FullSanitizer.new
    SITE = "http://www.pymblehifi.com.au/"

    element ".//td/span" => :name, :with => lambda { |node| self.tidy(node.inner_html.gsub('+', '')) }
    element ".//td[@class = 'style7']/div[@class = 'style7']" => :description, :with => lambda { |node| 
      self.tidy(node.inner_html.scan(/\((.*)\)/)[0][0]) }
    element ".//td/span" => :url, :with => lambda { |node| SITE + "#{self.tidy(node.inner_html).downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-') }
    element ".//td[@class = 'style7']/div[@class = 'style7']" => :original_price, :with => lambda { |node| 
       "$" + node.inner_html.strip.gsub(",","").scan(/\$([0-9\.,.]{1,})/).map { |x| x.first.to_i }.min.to_s }
    element ".//td[@class = 'style7']/div[@class = 'style7']/strong/font[@color = '#FF0000']" => :price

    # in this case there's no description in the datasource, so we return an empty string instead
    def to_hash
      { :shop_name    => "Pymble",
        :shop_address => "",
        :shop_suburb  => "",
        :shop_city    => "",
        :shop_state   => "NSW",
        :shop_country => "Australia" }.merge(super)
    end

    def self.tidy(value)
     value = Iconv.conv('ASCII//IGNORE//TRANSLIT', 'UTF-8', value)
     value = @@sanitizer.sanitize(value)
     value = value.strip.gsub(/[\n]/," ")
     value = value.strip.gsub(/[\r]/," ")
     value = value.gsub(/[ ]+/, " ")
    end

end

class Pymble < Nibbler
  elements '//div[@class = "Specials"]/table/tr[position() > 3]' => :items, :with => PymbleItem
end
