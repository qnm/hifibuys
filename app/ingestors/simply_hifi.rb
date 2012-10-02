require 'nibbler'
require 'uri'
include Feed

class SimplyHifiItem < Nibbler
  SITE = "http://www.simplyhifi.com.au/"

  element "./td[1]/div/center/table/tr/td/p/font" => :description, :with => lambda { |node| tidy(node.inner_html) }
  element "./td[1]/div/center/table/tr/td/p/font/b" => :name, :with => lambda { |node| tidy(node.inner_html) }
  element "./td[1]/div/center/table/tr/td/p/font/b" => :url, :with => lambda { |node| SITE  + "?source=hifibuys.com.au&product=#{tidy(node.inner_html).downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-') }
  element "./td[1]/div/center/table/tr/td/p/font" => :original_price, :with => lambda { |node|  node.text.scan(/(\$[0-9,]{1,})/).flatten.first.to_s.gsub(',','') }
  element "./td[2]/b/font" => :price

  def to_hash
    { 
      :seller_id    => 10,
      :submitter_id => 10,
    }.merge(super)
  end
end

class SimplyHifi < Nibbler
  consumes "http://www.simplyhifi.com.au/Trade_ins.htm"
  synchronises Item, :unique => :url

  elements '/html/body/div[position() > 5]/center/table/tbody/tr' => :items, :with => SimplyHifiItem
end
