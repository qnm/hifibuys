require 'nibbler'
require 'uri'
require 'html/sanitizer'
include Feed

class SimplyHifiItem < Nibbler
    @@sanitizer = HTML::FullSanitizer.new
    SITE = "http://www.simplyhifi.com.au/"

    element "./td[1]/div/center/table/tr/td/p/font" => :description, :with => lambda { |node| self.tidy(node.inner_html) }
    element "./td[1]/div/center/table/tr/td/p/font/b" => :name, :with => lambda { |node| self.tidy(node.inner_html) }
    element "./td[1]/div/center/table/tr/td/p/font/b" => :url, :with => lambda { |node| SITE  + "?source=hifibuys.com.au&product=#{self.tidy(node.inner_html).downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-') }
    element "./td[1]/div/center/table/tr/td/p/font" => :original_price, :with => lambda { |node| 
      '$' + node.inner_html.scan(/\$([0-9,]{1,})/).first.to_s.gsub(',','') }
    element "./td[2]/b/font" => :price

    # in this case there's no description in the datasource, so we return an empty string instead
    def to_hash
      { :shop_name    => "Simply Hifi",
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

class SimplyHifi < Nibbler
  consumes "http://www.simplyhifi.com.au/Trade_ins.htm"
  synchronises Item, :unique => :url

  elements '/html/body/div[position() > 5]/center/table/tbody/tr' => :items, :with => SimplyHifiItem
end
